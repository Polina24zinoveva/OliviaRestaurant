package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.UserWithoutLink;
import com.example.OliviaRestaurant.services.UserService;
import com.example.OliviaRestaurant.statics.StaticMethods;
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

    @GetMapping("/activate/{code}")
    public String activate(@PathVariable String code, Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        LocalDate maxDate = LocalDate.now();
        model.addAttribute("maxDate", maxDate);

        boolean isActivated = userService.activateUser(code);
        if (isActivated) model.addAttribute("message", "Ваш аккаунт активирован");
        else model.addAttribute("error", "Код не найден");
        return "login";
    }

    @PostMapping("/registration")
    public String createUser(UserWithoutLink userWithoutLink, Model model,
                             @RequestParam(name = "password") String password,
                             @RequestParam(name = "password2") String password2) {

        if (!password.equals(password2)) {
            error = "Пароли не совпадают. Повторите снова";
            return "redirect:/login";
        }

        User user = userService.getUserByEmail(userWithoutLink.getEmail());
        if (user != null) {
            warning = "На этот email уже зарегистрирован аккаунт";
        }
        else {
            message = "На вашу электронную почту отправлен код для активации аккаунта";
            if (!userService.createUser(userWithoutLink)) {
                return "redirect:/login?error";
            }
        }
        return "redirect:/login";
    }

}
