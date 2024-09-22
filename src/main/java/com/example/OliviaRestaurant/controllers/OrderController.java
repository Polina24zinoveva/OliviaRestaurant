package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Dish;
import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.services.*;
import com.example.OliviaRestaurant.statics.StaticMethods;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

@AllArgsConstructor
@Controller
public class OrderController {
    @Autowired
    public final OrderService orderService;

    @Autowired
    public final OrderHasDishService orderHasDishService;

    @Autowired
    private final UserService userService;

    @Autowired
    private DishService dishService;

    @GetMapping("/order/add")
    public String addOrder(Order order, Principal principal, Model model,
                           @AuthenticationPrincipal User user) throws IOException {
        StaticMethods.header(user, model);
        orderService.saveOrder(principal, order);
        return "redirect:/order";
    }

    @GetMapping("/getOrders")
    public String getOrders(Principal principal, Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        model.addAttribute("orders", orderService.ListOrders());
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "order";
    }

    @GetMapping("/order")
    public String getDishOrders(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        try {

            // Получение текущей даты
            LocalDate minDate = LocalDate.now();

            // Получение текущей даты плюс три месяца
            LocalDate maxDate = minDate.plus(3, ChronoUnit.MONTHS);

            int hourNow = LocalTime.now().getHour();
            if(hourNow >= 22){
                minDate = minDate.plus(1, ChronoUnit.DAYS);
            }


            model.addAttribute("dishes", orderHasDishService.getDishesByOrder(orderService.HaveOrderInCardByUser(user)));

            model.addAttribute("amounts", orderHasDishService.getAmountsByOrder(orderService.HaveOrderInCardByUser(user)));
            List<Integer> acAmounts = orderHasDishService.getAmountsByOrder(orderService.HaveOrderInCardByUser(user));
            Long countDishesInOrder = 0L;
            for(int i = 0; i < acAmounts.size(); i++){
                countDishesInOrder += acAmounts.get(i);
            }
            String countDishesInOrderString = "";
            if (countDishesInOrder == 1){ countDishesInOrderString = "1 блюдо";}
            else if (countDishesInOrder >= 2 && countDishesInOrder <= 4){countDishesInOrderString = countDishesInOrder + " блюда";}
            else {countDishesInOrderString = countDishesInOrder + " блюд";}

            model.addAttribute("countDishesInOrderString", countDishesInOrderString);

            model.addAttribute("order", orderService.HaveOrderInCardByUser(user));


            // Передача номера телефона в модель
            model.addAttribute("phoneNumber", user.getPhoneNumber());

            model.addAttribute("minDate", minDate);
            model.addAttribute("maxDate", maxDate);


            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && authentication.isAuthenticated()) {
                // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
                String username = authentication.getName(); // Получить имя пользователя
                User user1 = userService.getUserByEmail(username);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "order";
    }

    @PostMapping("/addDishToOrder/{id}")
    public String addDishToOrder(@PathVariable Long id, Principal principal, RedirectAttributes redirectAttributes){
        try {
            Dish dish  = dishService.getDishByID(id);
            orderHasDishService.createOrderHasDish(dish, principal);
            redirectAttributes.addFlashAttribute("message", "Блюдо добавлено в корзину");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при добавлении блюда в корзину");
        }

        return "redirect:/order";
    }

    @PostMapping("/deleteDishFromOrder/{id}")
    public String deleteDishFromOrder(@PathVariable Long id, Principal principal, RedirectAttributes redirectAttributes){
        try {
            Dish dish  = dishService.getDishByID(id);
            orderHasDishService.removeOrderHasDish(dish, principal);
            redirectAttributes.addFlashAttribute("message", "Блюдо удалено из заказа");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при удалении блюда из заказа");
        }

        return "redirect:/order";
    }

    @PostMapping("/changeDishCount/{id}")
    public String changeDishCount(@PathVariable Long id, @RequestParam(name = "count") Integer count, Principal principal, RedirectAttributes redirectAttributes){
        try{
            Dish dish = dishService.getDishByID(id);
            orderHasDishService.changeAmount(dish, principal, count);
        }catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при изменении стоимости");
        }

        return "redirect:/order";
    }


    @PostMapping("/orderCheckout")
    public String CheckoutDish(@RequestParam(name = "addressDelivery") String addressDelivery,
                               @RequestParam(name = "dateDelivery") LocalDate dateDelivery,
                               @RequestParam(name = "timeDelivery") String timeDelivery,
                                  Principal principal, RedirectAttributes redirectAttributes){
        LocalDateTime datePayment = LocalDateTime.now();

        try{
            orderService.CheckoutOrder(principal, addressDelivery, datePayment, dateDelivery, timeDelivery);
            redirectAttributes.addFlashAttribute("message", "Заказ оформлен. Оплата курьеру при получении");
        }catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при оформлении заказа");
        }

        return "redirect:/profile";
    }

    // Метод для отображения страницы с заказами и курьерами
    @PostMapping("/assignCourier/{orderId}")
    public String assignCourier(@PathVariable Long orderId, Long courierId, Model model) {
        Order order = orderService.getOrderByID(orderId);
        User courier = userService.getUserById(courierId);

        // Назначаем курьера
        order.setCourier(courier);
        orderService.saveOrder(order);

        // Обновляем список курьеров
        List<User> couriers = userService.listAllCouriers();
        model.addAttribute("couriers", couriers);

        return "redirect:/managerProfile"; // Возвращаемся на страницу с заказами
    }
}

