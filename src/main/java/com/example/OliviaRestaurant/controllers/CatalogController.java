package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Dish;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.services.*;
import com.example.OliviaRestaurant.statics.StaticMethods;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import org.hibernate.Session;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.OptionalDouble;

@AllArgsConstructor
@Controller
public class CatalogController {

    private final DishService dishService;


    @GetMapping("/catalog")
    public String catalog(Model model, @AuthenticationPrincipal User user,
                          @RequestParam(value = "sort", required = false, defaultValue = "0") int sortType,
                          @RequestParam(value = "cuisine", required = false, defaultValue = "all") String cuisineType,
                          @RequestParam(value = "dishType", required = false, defaultValue = "all") String dishType) {
        StaticMethods.header(user, model);

        List<Dish> dishesList = dishService.listDishesInMenu();


        switch (cuisineType) {
            case "russian":
                dishesList = dishesList.stream().filter(dish -> dish.getCuisine().getName().equals("Русская")).toList();
                break;
            case "european":
                dishesList = dishesList.stream().filter(dish -> dish.getCuisine().getName().equals("Европейская")).toList();
                break;
            case "italian":
                dishesList = dishesList.stream().filter(dish -> dish.getCuisine().getName().equals("Итальянская")).toList();
                break;
            case "asian":
                dishesList = dishesList.stream().filter(dish -> dish.getCuisine().getName().equals("Азиатская")).toList();
                break;
            default:
                break;
        }
        model.addAttribute("selectedCuisine", cuisineType);

        switch (dishType) {
            case "rolls":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Роллы")).toList();
                break;
            case "salads":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Салаты")).toList();
                break;
            case "soups":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Супы")).toList();
                break;
            case "appetizers":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Горячие закуски и гарниры")).toList();
                break;
            case "pizza":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Пицца")).toList();
                break;
            case "hotDishes":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Горячие блюда")).toList();
                break;
            case "wok":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Wok")).toList();
                break;
            case "pasta":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Паста")).toList();
                break;
            case "desserts":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Десерты")).toList();
                break;
            case "softDrinks":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Безалкогольные напитки")).toList();
                break;
            case "alcoholicDrinks":
                dishesList = dishesList.stream().filter(dish -> dish.getDishType().getName().equals("Алкогольные напитки")).toList();
                break;
            default:
                break;
        }
        model.addAttribute("selectedDishType", dishType);

        List<Dish> dishes = new ArrayList<>(dishesList);

        switch (sortType) {
            case 1:
                // Сортировка по возрастанию цены
                dishes.sort(Comparator.comparing(Dish::getPrice));
                break;
            case 2:
                // Сортировка по убыванию цены
                dishes.sort(Comparator.comparing(Dish::getPrice).reversed());
                break;
            default:
                break;
        }
        model.addAttribute("selectedSort", sortType);

        model.addAttribute("allDishes", dishes);
        String title = "Все блюда: ";
        model.addAttribute("title", title);

        return "catalog";
    }

}