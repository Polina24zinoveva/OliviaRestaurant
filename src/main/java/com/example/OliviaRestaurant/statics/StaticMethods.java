package com.example.OliviaRestaurant.statics;

import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.enums.Role;
import org.springframework.ui.Model;

public class StaticMethods {
    public static void header(User user, Model model){
        if (user == null) model.addAttribute("statusUser", null);
        else{
            if (user.getRole() == Role.ROLE_ADMIN) model.addAttribute("userRole", Role.ROLE_ADMIN);
            if (user.getRole() == Role.ROLE_MANAGER) model.addAttribute("userRole", Role.ROLE_MANAGER);
            if (user.getRole() == Role.ROLE_COURIER) model.addAttribute("userRole", Role.ROLE_COURIER);
            if (user.getRole() == Role.ROLE_USER) model.addAttribute("userRole", Role.ROLE_USER);
        }
    }
}
