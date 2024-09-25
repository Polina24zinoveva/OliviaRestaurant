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
        model.addAttribute("activeOrder", activeOrder);
        model.addAttribute("activeOrderDishes", orderHasDishService.getPendingDishes(activeOrder));
        model.addAttribute("activeOrderAmounts", orderHasDishService.getPendingAmount(activeOrder));

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o1.getDateDelivery().compareTo(o2.getDateDelivery()))
                .collect(Collectors.toList());


        List<User> couriers = userService.listAllCouriers();

//        LocalDate today = LocalDate.now();
//        List<Integer> list1 = orderService.getCourierOrdersCountForAllDates(today, couriers);
//        List<Integer> list2 = orderService.getCourierOrdersCountForAllDates(today.plus(1, ChronoUnit.DAYS), couriers);
//        List<Integer> list3 = orderService.getCourierOrdersCountForAllDates(today.plus(2, ChronoUnit.DAYS), couriers);
//        List<Integer> list4 = orderService.getCourierOrdersCountForAllDates(today.plus(3, ChronoUnit.DAYS), couriers);
//        List<Integer> list5 = orderService.getCourierOrdersCountForAllDates(today.plus(4, ChronoUnit.DAYS), couriers);
//        List<Integer> list6 = orderService.getCourierOrdersCountForAllDates(today.plus(5, ChronoUnit.DAYS), couriers);
//        List<Integer> list7 = orderService.getCourierOrdersCountForAllDates(today.plus(6, ChronoUnit.DAYS), couriers);
//        List<Integer> list8 = orderService.getCourierOrdersCountForAllDates(today.plus(7, ChronoUnit.DAYS), couriers);


        model.addAttribute("currentUser", user);
        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));
        model.addAttribute("courierOrdersCount", orderService.getCourierOrdersCountForAllDates(sortedOrders, couriers));

        //model.addAttribute("courierOrdersCount", courierOrdersCount);
//        model.addAttribute("list1", list1);
//        model.addAttribute("list2", list2);
//        model.addAttribute("list3", list3);
//        model.addAttribute("list4", list4);
//        model.addAttribute("list5", list5);
//        model.addAttribute("list6", list6);
//        model.addAttribute("list7", list7);
//        model.addAttribute("list8", list8);

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

        return "managerHistoryOrders";
    }
}
