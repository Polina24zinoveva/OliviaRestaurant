package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.services.*;
import lombok.AllArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.stream.Collectors;

@AllArgsConstructor
@Controller
public class ProfileController {

    private final OrderService orderService;
    private final OrderHasDishService orderHasDishService;

    @GetMapping("/profile")
    public String profile(Model model, @AuthenticationPrincipal User user) {
        List<Order> orders = orderService.ListOrdersActive(user); // Получаем заказы пользователя
        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o1.getDateTimeDelivery().compareTo(o2.getDateTimeDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("currentUser", user);
        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        return "profile";
    }

    @GetMapping("/historyOrders")
    public String historyOrders(Model model, @AuthenticationPrincipal User user) {
        List<Order> finishedOrders = orderService.ListOrdersFinished(user); // Получаем заказы пользователя
        // Сортируем заказы по дате доставки
        List<Order> sortedFinishedOrders = finishedOrders.stream()
                .sorted((o1, o2) -> o2.getDateTimeDelivery().compareTo(o1.getDateTimeDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("finishedOrders", sortedFinishedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedFinishedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedFinishedOrders));
        model.addAttribute("currentUser", user);

        return "historyOrders";
    }
}
