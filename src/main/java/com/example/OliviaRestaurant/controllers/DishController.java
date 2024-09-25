package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Dish;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.List;
import java.util.Objects;

@Controller
@AllArgsConstructor
public class DishController {
    @Autowired
    private final DishService dishService;
    @Autowired
    private final OrderHasDishService orderHasDishService;
    @Autowired
    private final OrderService orderService;
    @Autowired
    private final UserService userService;



    @GetMapping("/dish/{id}")
    public String dish(@PathVariable Long id, Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        Dish dish = dishService.getDishByID(id);
        model.addAttribute("dish", dish);

        if (user != null) {
            //model.addAttribute("isAdmin", user.getIsAdministrator());
            List<Dish> dishList = orderHasDishService.getDishesByOrder(orderService.haveOrderInCardByUser(user));

            // Проверяем наличие нужного id букета в списке
            boolean dishExists = false;
            for (Dish dishB : dishList) {
                if (Objects.equals(dishB.getId(), id)) {
                    dishExists = true;
                    break;
                }
            }
            if (dishExists) {
                model.addAttribute("inCard", true);
            } else {
                model.addAttribute("inCard", false);
            }
        }

        else{
            model.addAttribute("isAdmin", false);
            model.addAttribute("inCard", false);
        }
        return "dish";
    }

    @PostMapping("/addToCartDish/{id}")
    public String addToCartDish(@PathVariable Long id, Principal principal, RedirectAttributes redirectAttributes) {
        try{
            //проверка пользователя администратор он или нет
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
            String username = authentication.getName(); // Получить имя пользователя
            User user = userService.getUserByEmail(username);
            if (user != null){
                List<Dish> dishList = orderHasDishService.getDishesByOrder(orderService.haveOrderInCardByUser(user));

                // Проверяем наличие нужного id блюда в списке
                boolean dishExists = false;
                for (Dish dishB : dishList) {
                    if (Objects.equals(dishB.getId(), id)) {
                        dishExists = true;
                        break;
                    }
                }

                if (dishExists) {
                    redirectAttributes.addFlashAttribute("warning", "Блюдо уже в корзине");
                } else {
                    Dish dish = dishService.getDishByID(id);
                    orderHasDishService.createOrderHasDish(dish, principal);
                    redirectAttributes.addFlashAttribute("message", "Успешно добавлено в корзину");
                }
            }

        }catch (Exception e){
            redirectAttributes.addFlashAttribute("error", "Ошибка при добавлении в корзину");
        }
        return "redirect:/dish/{id}";
    }

}
