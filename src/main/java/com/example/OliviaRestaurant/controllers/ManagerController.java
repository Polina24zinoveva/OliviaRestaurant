package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.enums.OrderStatus;
import com.example.OliviaRestaurant.repositories.OrderRepository;
import com.example.OliviaRestaurant.services.OrderHasDishService;
import com.example.OliviaRestaurant.services.OrderService;
import com.example.OliviaRestaurant.services.UserService;
import com.example.OliviaRestaurant.statics.StaticMethods;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@AllArgsConstructor
@Controller
public class ManagerController {

    private final OrderService orderService;
    private final OrderHasDishService orderHasDishService;
    private final UserService userService;
    private final OrderRepository orderRepository;

    @GetMapping("/managerProfile")
    @PreAuthorize("hasRole('ROLE_MANAGER')")
    public String profile(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);
        List<Order> orders = orderService.listAllOrdersToDeliver();

        List<Order> activeOrder = orderRepository.findAllByStatus(OrderStatus.STATUS_IN_DELIVERY);
        if (!activeOrder.isEmpty()) {
            model.addAttribute("activeOrder", activeOrder);
            model.addAttribute("activeOrderDishes", orderHasDishService.getPendingDishes(activeOrder));
            model.addAttribute("activeOrderAmounts", orderHasDishService.getPendingAmount(activeOrder));
            model.addAttribute("activeDatesDelivery", orderHasDishService.getDatesDelivery(activeOrder));
            model.addAttribute("activeDatesTimePayment", orderHasDishService.getDatesTimePayment(activeOrder));
        }

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream().sorted(Comparator.comparing(Order::getDateDelivery)
                        .thenComparing(order -> LocalTime.parse(order.getTimeDelivery())))
                .collect(Collectors.toList());


        List<User> couriers = userService.listAllCouriers();

        model.addAttribute("currentUser", user);
        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));
        model.addAttribute("datesDelivery", orderHasDishService.getDatesDelivery(sortedOrders));
        model.addAttribute("datesTimePayment", orderHasDishService.getDatesTimePayment(sortedOrders));

        model.addAttribute("courierOrdersCount", orderService.getCourierOrdersCountForAllDates(sortedOrders, couriers));

        model.addAttribute("couriers", couriers);
        return "managerProfile";
    }




    @GetMapping("/managerHistoryOrders")
    @PreAuthorize("hasRole('ROLE_MANAGER')")
    public String historyOrders(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        List<Order> orders = orderService.listOrdersFinished();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream().sorted(Comparator.comparing(Order::getCourierDateTimeDelivery)).collect(Collectors.toList());

        model.addAttribute("currentUser", user);
        model.addAttribute("finishedOrders", sortedOrders);
        model.addAttribute("finishedDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("finishedAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        model.addAttribute("datesDelivery", orderHasDishService.getDatesDelivery(sortedOrders));
        model.addAttribute("datesTimePayment", orderHasDishService.getDatesTimePayment(sortedOrders));
        model.addAttribute("courierDatesTimeDelivery", orderHasDishService.getCourierDatesTimeDelivery(sortedOrders));

        return "managerHistoryOrders";
    }

}
