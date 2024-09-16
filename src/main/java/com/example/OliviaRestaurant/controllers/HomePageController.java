package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Restaurant;
import com.example.OliviaRestaurant.repositories.RestaurantRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
@AllArgsConstructor
public class HomePageController {

    RestaurantRepository restaurantRepository;

    @GetMapping("/")
    public String adminFindDishByName(Model model){
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
