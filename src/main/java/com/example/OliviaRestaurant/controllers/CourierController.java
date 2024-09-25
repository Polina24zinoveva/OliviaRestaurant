package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.enums.OrderStatus;
import com.example.OliviaRestaurant.repositories.OrderRepository;
import com.example.OliviaRestaurant.services.OrderHasDishService;
import com.example.OliviaRestaurant.services.OrderService;
import com.example.OliviaRestaurant.statics.StaticMethods;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@AllArgsConstructor
@Controller
public class CourierController {

    private final OrderService orderService;
    private final OrderHasDishService orderHasDishService;
    private final OrderRepository orderRepository;

    @GetMapping("/courierProfile")
    @PreAuthorize("hasRole('ROLE_COURIER')")
    public String profile(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);
        List<Order> orders = orderService.listAllOrdersToDeliverByCourier(user);

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream().sorted(Comparator.comparing(Order::getDateDelivery)
                        .thenComparing(order -> LocalTime.parse(order.getTimeDelivery())))
                .collect(Collectors.toList());

        List<Order> activeOrder = orderRepository.findByCourierAndStatus(user, OrderStatus.STATUS_IN_DELIVERY);
        if (activeOrder.size() == 1){
            model.addAttribute("activeOrder", activeOrder.getFirst());
            model.addAttribute("activeOrderDishes", orderHasDishService.getPendingDishes(activeOrder).getFirst());
            model.addAttribute("activeOrderAmounts", orderHasDishService.getPendingAmount(activeOrder).getFirst());
        }

        model.addAttribute("currentUser", user);

        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        return "courierProfile";
    }

    @GetMapping("/courierHistoryOrders")
    @PreAuthorize("hasRole('ROLE_COURIER')")
    public String historyOrders(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        List<Order> orders = orderRepository.findByCourierAndStatus(user, OrderStatus.STATUS_DELIVERED);


        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream().sorted(Comparator.comparing(Order::getCourierDateTimeDelivery)).collect(Collectors.toList());

        model.addAttribute("currentUser", user);
        model.addAttribute("finishedOrders", sortedOrders);
        model.addAttribute("finishedDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("finishedAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        return "courierHistoryOrders";
    }


    @PostMapping("/startDelivery")
    @PreAuthorize("hasRole('ROLE_COURIER')")
    public String startDelivery(Model model, @AuthenticationPrincipal User user,
                                @RequestParam Long orderId, RedirectAttributes redirectAttributes){
        StaticMethods.header(user, model);

        if (orderRepository.findByCourierAndStatus(user, OrderStatus.STATUS_IN_DELIVERY).isEmpty()){
            Order order = orderRepository.findById(orderId).orElse(null);
            if (order.getDateDelivery().equals(LocalDate.now())){
                order.setStatus(OrderStatus.STATUS_IN_DELIVERY);
                orderRepository.save(order);
                redirectAttributes.addFlashAttribute("message", "Началось выполнение заказа");
            }
            else redirectAttributes.addFlashAttribute("error", "Нельзя сейчас начать выполнение заказа на другую дату");

        }
        else redirectAttributes.addFlashAttribute("error", "У вас уже есть заказ в доставке");

        return "redirect:/courierProfile";
    }

    @PostMapping("finishOrder/{id}")
    @PreAuthorize("hasRole('ROLE_COURIER')")
    public String finishOrder(@PathVariable Long id, RedirectAttributes redirectAttributes){
        try{
            Order order = orderService.getOrderByID(id);
            order.setStatus(OrderStatus.STATUS_DELIVERED);
            order.setCourierDateTimeDelivery(LocalDateTime.now());
            orderService.saveOrder(order);
            redirectAttributes.addFlashAttribute("message", "Заказ доставлен");
        } catch(Exception e){
            redirectAttributes.addFlashAttribute("message", "Ошибка при доставке заказа");
        }

        return"redirect:/courierProfile";
    }
}
