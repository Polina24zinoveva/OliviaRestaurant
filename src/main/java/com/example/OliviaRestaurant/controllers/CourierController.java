package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.services.OrderHasDishService;
import com.example.OliviaRestaurant.services.OrderService;
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
public class CourierController {

    private final OrderService orderService;
    private final OrderHasDishService orderHasDishService;

    @GetMapping("/courierProfile")
    public String profile(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);
        List<Order> orders = orderService.ListAllOrdersToDeliverByCourier(user);

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o1.getDateDelivery().compareTo(o2.getDateDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("currentUser", user);
        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        return "courierProfile";
    }

    @GetMapping("/courierHistoryOrders")
    public String historyOrders(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        List<Order> orders = orderService.ListOrdersFinished();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o2.getDateDelivery().compareTo(o1.getDateDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("currentUser", user);
        model.addAttribute("finishedOrders", sortedOrders);
        model.addAttribute("finishedDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("finishedAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        return "courierHistoryOrders";
    }
}
