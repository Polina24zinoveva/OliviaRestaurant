package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.services.UserService;
import com.example.OliviaRestaurant.statics.StaticMethods;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
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
    public String login(Model model, @AuthenticationPrincipal User user, HttpSession session){
        StaticMethods.header(user, model);


        if ((String) session.getAttribute("userEmail") != null) model.addAttribute("userEmail", (String) session.getAttribute("userEmail"));

        if (message != null) model.addAttribute("message", message);
        if (warning != null) model.addAttribute("warning", warning);
        if (error != null) model.addAttribute("error", error);
        message = null;
        warning = null;
        error = null;

        return "login";
    }


    @GetMapping("/login_not_success")
    public String login_not_success(HttpSession session) {

        if (userService.getUserByEmail((String) session.getAttribute("userEmail")) == null){
            error = "Не верный email";
            System.out.println("Не верный email");
        }
        else{
            System.out.println("Не верный пароль");
            error = "Не верный пароль";
        }
        return "redirect:/login";
    }

    @GetMapping("/registration")
    public String registration(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        return "registration";
    }

    @PostMapping("/registration")
    public String createUser(User user, Model model) {

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
