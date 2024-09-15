package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Dish;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.services.*;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

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
    public String dish(@PathVariable Long id, Model model){
        Dish dish = dishService.getDishByID(id);
        model.addAttribute("dish", dish);

        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);
        if (user != null) {
            //model.addAttribute("isAdmin", user.getIsAdministrator());
            List<Dish> dishList = orderHasDishService.getDishesByOrder(orderService.HaveOrderInCardByUser(user));

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

}
