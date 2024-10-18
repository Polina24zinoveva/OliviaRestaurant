package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.services.UserService;
import com.example.OliviaRestaurant.statics.StaticMethods;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;

@Controller

public class UserController {
    @Autowired
    private final UserService userService;

    private String message = null;
    private String warning = null;
    private String error = null;


    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String login(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        LocalDate maxDate = LocalDate.now();
        model.addAttribute("maxDate", maxDate);

        if (message != null) model.addAttribute("message", message);
        if (warning != null) model.addAttribute("warning", warning);
        if (error != null) model.addAttribute("error", error);
        message = null;
        warning = null;
        error = null;

        return "login";
    }

    @GetMapping("/login_not_success")
    public String login_not_success(@RequestParam(name = "email", required = false) String email) {
        if (email != null) {
            System.out.println(email);
        }
        System.out.println("Не верный email или пароль");
        error = "Не верный email или пароль";
        return "redirect:/login";
    }

    @GetMapping("/registration")
    public String registration(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        return "registration";
    }

    @PostMapping("/registration")
    public String createUser(User user, Model model,
                             @RequestParam(name = "password") String password,
                             @RequestParam(name = "password2") String password2) {

        if (!password.equals(password2)) {
            error = "Пароли не совпадают. Повторите ввести их снова";
            return "redirect:/login";
        }

        if (userService.getUserByEmail(user.getEmail()) != null) {
            warning = "На этот email уже зарегистрирован аккаунт";
        }
        else {
            try {
                userService.createUser(user);
                message = "Вы зарегистрированы";
            }
            catch (Exception e){
                error = "Произошла ошибка";
            }
        }
        return "redirect:/login";
    }

}
