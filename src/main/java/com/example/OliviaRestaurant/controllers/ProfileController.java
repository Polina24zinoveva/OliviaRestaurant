package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.enums.Role;
import com.example.OliviaRestaurant.services.*;
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
public class ProfileController {

    private final OrderService orderService;
    private final OrderHasDishService orderHasDishService;

    @GetMapping("/profile")
    public String profile(Model model, @AuthenticationPrincipal User user){
        if (user.getRole() == Role.ROLE_ADMIN) return "redirect:/adminOrderList";
        if (user.getRole() == Role.ROLE_MANAGER) return "redirect:/managerProfile";
        if (user.getRole() == Role.ROLE_COURIER) return "redirect:/courierProfile";


        StaticMethods.header(user, model);

        List<Order> orders = orderService.ListOrdersActive(user); // Получаем заказы пользователя
        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o1.getDateDelivery().compareTo(o2.getDateDelivery()))
                .collect(Collectors.toList());

        List<Order> sortedFinishedOrders = orders.stream()
                .sorted((o1, o2) -> o2.getDateDelivery().compareTo(o1.getDateDelivery()))
                .collect(Collectors.toList());


        model.addAttribute("currentUser", user);
        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        return "profile";
    }

    @GetMapping("/historyOrders")
    public String historyOrders(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        List<Order> finishedOrders = orderService.listOrdersFinished(user); // Получаем заказы пользователя
        // Сортируем заказы по дате доставки
        List<Order> sortedFinishedOrders = finishedOrders.stream()
                .sorted((o1, o2) -> o2.getDateDelivery().compareTo(o1.getDateDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("finishedOrders", sortedFinishedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedFinishedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedFinishedOrders));
        model.addAttribute("currentUser", user);

        return "historyOrders";
    }
}
