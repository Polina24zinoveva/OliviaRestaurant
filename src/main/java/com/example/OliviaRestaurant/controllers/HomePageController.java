package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Restaurant;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.repositories.RestaurantRepository;
import com.example.OliviaRestaurant.statics.StaticMethods;
import lombok.AllArgsConstructor;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.Optional;

@Controller
@AllArgsConstructor
public class HomePageController {

    RestaurantRepository restaurantRepository;

    @GetMapping("/")
    public String adminFindDishByName(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        Optional<Restaurant> optionalRestaurant = restaurantRepository.findById(1L);

        if (optionalRestaurant.isPresent()) {
            Restaurant restaurant = optionalRestaurant.get();
            model.addAttribute("address", restaurant.getAddress());
            model.addAttribute("openHours", restaurant.getOpenHours());
            model.addAttribute("closeHours", restaurant.getCloseHours());
        } else {
            model.addAttribute("error", "Restaurant not found.");
        }
        return "home";
    }
}
