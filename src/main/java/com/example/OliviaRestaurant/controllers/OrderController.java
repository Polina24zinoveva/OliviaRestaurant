package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Dish;
import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.repositories.OrderHasDishRepository;
import com.example.OliviaRestaurant.services.*;
import com.example.OliviaRestaurant.statics.StaticMethods;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Controller
public class OrderController {
    @Autowired
    public final OrderService orderService;

    @Autowired
    public final OrderHasDishService orderHasDishService;
    private final OrderHasDishRepository orderHasDishRepository;

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

        model.addAttribute("orders", orderService.listOrders());
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "order";
    }

    @GetMapping("/order")
    public String getDishOrders(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        try {

            // Получение текущей даты
            LocalDate minDate = LocalDate.now();

            // Получение текущей даты плюс 1 неделя
            LocalDate maxDate = minDate.plus(1, ChronoUnit.WEEKS);

            int hourNow = LocalTime.now().getHour();
            if(hourNow >= 22){
                minDate = minDate.plus(1, ChronoUnit.DAYS);
            }


            model.addAttribute("dishes", orderHasDishService.getDishesByOrder(orderService.haveOrderInCardByUser(user)));

            model.addAttribute("amounts", orderHasDishService.getAmountsByOrder(orderService.haveOrderInCardByUser(user)));
            List<Integer> acAmounts = orderHasDishService.getAmountsByOrder(orderService.haveOrderInCardByUser(user));
            Long countDishesInOrder = 0L;
            for(int i = 0; i < acAmounts.size(); i++){
                countDishesInOrder += acAmounts.get(i);
            }
            String countDishesInOrderString = "";
            if (countDishesInOrder == 1){ countDishesInOrderString = "1 блюдо";}
            else if (countDishesInOrder >= 2 && countDishesInOrder <= 4){countDishesInOrderString = countDishesInOrder + " блюда";}
            else {countDishesInOrderString = countDishesInOrder + " блюд";}

            model.addAttribute("countDishesInOrderString", countDishesInOrderString);

            model.addAttribute("order", orderService.haveOrderInCardByUser(user));


            // Передача номера телефона в модель
            model.addAttribute("phoneNumber", user.getPhoneNumber());

            model.addAttribute("minDate", minDate);
            model.addAttribute("maxDate", maxDate);


        } catch (Exception e) {
            e.printStackTrace();
        }
        return "order";
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

    @PostMapping("/increaseDishCount")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> increaseDishCount(
            @RequestParam String dishId, @RequestParam String action,
            Principal principal, @AuthenticationPrincipal User user) {

        Map<String, Object> response = new HashMap<>();

        try {
            if (action.equals("increase")){
                List<Integer> acAmounts = orderHasDishService.getAmountsByOrder(orderService.haveOrderInCardByUser(user));
                Long countDishesInOrder = 0L;
                for(int i = 0; i < acAmounts.size(); i++){
                    countDishesInOrder += acAmounts.get(i);
                }

                if (countDishesInOrder >= 50) {
                    response.put("success", "false");
                    response.put("message", "Нельзя заказать более 50 блюд ");
                    response.put("disableIncreaseButton", true); // Добавляем флаг для блокировки кнопки
                    return ResponseEntity.ok(response);
                }
            }


            Dish dish = dishService.getDishByID(Long.parseLong(dishId));
            int amount = orderHasDishService.increaseAmount(dish, principal, action);

            response.put("success", "true");
            response.put("message", "Количество успешно обновлено");

            response.put("newAmount", amount);

            List<Integer> acAmounts = orderHasDishService.getAmountsByOrder(orderService.haveOrderInCardByUser(user));
            Long countDishesInOrder = 0L;
            for(int i = 0; i < acAmounts.size(); i++){
                countDishesInOrder += acAmounts.get(i);
            }
            String countDishesInOrderString = "";
            if (countDishesInOrder == 1){ countDishesInOrderString = "1 блюдо";}
            else if (countDishesInOrder >= 2 && countDishesInOrder <= 4){countDishesInOrderString = countDishesInOrder + " блюда";}
            else {countDishesInOrderString = countDishesInOrder + " блюд";}

            response.put("totalPrice", orderService.haveOrderInCardByUser(user).getTotalPrice());

            response.put("countDishesInOrderString", countDishesInOrderString);

            //response.put("newCount", count); // Можно вернуть обновлённое количество, если нужно
        } catch (Exception e) {
            response.put("success", "false");
            response.put("message", "Ошибка при изменении количества: " + e.getMessage());
        }

        return ResponseEntity.ok(response);
    }



    @PostMapping("/orderCheckout")
    public String CheckoutDish(@RequestParam(name = "addressDelivery") String addressDelivery,
                               @RequestParam(name = "dateDelivery") LocalDate dateDelivery,
                               @RequestParam(name = "timeDelivery") String timeDelivery,
                                  Principal principal, RedirectAttributes redirectAttributes){
        LocalDateTime datePayment = LocalDateTime.now();

        try{
            orderService.checkoutOrder(principal, addressDelivery, datePayment, dateDelivery, timeDelivery);
            redirectAttributes.addFlashAttribute("message", "Заказ оформлен. Оплата прошла");
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

