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
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.stream.Collectors;

@AllArgsConstructor
@Controller
public class ManagerController {

    private final OrderService orderService;
    private final OrderHasDishService orderHasDishService;
    private final UserService userService;
    private final OrderRepository orderRepository;

    @GetMapping("/managerProfile")
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

        List<Order> sortedOrders2 = orders.stream()
                .sorted((o1, o2) -> o1.getDateDelivery().compareTo(o2.getDateDelivery()))
                .collect(Collectors.toList());

        List<User> couriers = userService.listAllCouriers();

//        for(User courier: couriers){
//            orderService.findOrdersByCourierAndDate(courier, )
//        }


        model.addAttribute("currentUser", user);
        model.addAttribute("toDeliverOrders", sortedOrders2);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));
        model.addAttribute("couriers", couriers);
        model.addAttribute("couriersOrders", couriers);


        return "managerProfile";
    }

    @GetMapping("/managerHistoryOrders")
    public String historyOrders(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        List<Order> orders = orderService.listOrdersFinished();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o2.getDateDelivery().compareTo(o1.getDateDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("currentUser", user);
        model.addAttribute("finishedOrders", sortedOrders);
        model.addAttribute("finishedDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("finishedAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        return "managerHistoryOrders";
    }
}
