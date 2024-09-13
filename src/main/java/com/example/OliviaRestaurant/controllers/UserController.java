package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.UserWithoutLink;
import com.example.OliviaRestaurant.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

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
    public String login(Model model) {
        LocalDate maxDate = LocalDate.now();
        model.addAttribute("maxDate", maxDate);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        User user = userService.getUserByEmail(username);
        model.addAttribute("isAdmin", user != null && user.getIsAdministrator());
        if (message != null) model.addAttribute("message", message);
        if (warning != null) model.addAttribute("warning", warning);
        if (error != null) model.addAttribute("error", error);
        message = null;
        warning = null;
        error = null;

        return "login";
    }

    @GetMapping("/login_not_success")
    public String login_not_success() {
        error = "Не верный email или пароль";
        return "redirect:/login";
    }

    @GetMapping("/registration")
    public String registration(Model model){


        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        User user = userService.getUserByEmail(username);
        model.addAttribute("isAdmin", user != null && user.getIsAdministrator());
        return "registration";
    }
    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        LocalDate maxDate = LocalDate.now();
        model.addAttribute("maxDate", maxDate);

        boolean isActivated = userService.activateUser(code);
        model.addAttribute("message", isActivated ? "Ваш аккаунт активирован" : "Код не найден");
        return "login";
    }

    @PostMapping("/registration")
    public String createUser(UserWithoutLink userWithoutLink, Model model) {
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
