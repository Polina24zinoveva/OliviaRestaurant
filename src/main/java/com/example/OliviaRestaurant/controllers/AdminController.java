package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.*;
import com.example.OliviaRestaurant.models.enums.OrderStatus;
import com.example.OliviaRestaurant.models.enums.Role;
import com.example.OliviaRestaurant.repositories.CuisineRepository;
import com.example.OliviaRestaurant.repositories.DishRepository;
import com.example.OliviaRestaurant.repositories.DishTypeRepository;
import com.example.OliviaRestaurant.services.DishService;
import com.example.OliviaRestaurant.services.OrderHasDishService;
import com.example.OliviaRestaurant.services.OrderService;
import com.example.OliviaRestaurant.services.UserService;
import com.example.OliviaRestaurant.statics.StaticMethods;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@AllArgsConstructor
@Controller
public class AdminController {

    @Autowired
    private final DishService dishService;
    @Autowired
    private final OrderHasDishService orderHasDishService;
    @Autowired
    private final OrderService orderService;
    @Autowired
    private final UserService userService;

    private final CuisineRepository CuisineRepository;
    private final DishTypeRepository DishTypeRepository;
    private final DishRepository dishRepository;

    @GetMapping("/adminAllDish")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String admin(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        model.addAttribute("allDishes", dishService.listAllDishes());
        model.addAttribute("toDeliverOrders", orderService.listAllOrdersToDeliver());
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(orderService.listAllOrdersToDeliver()));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingDishes(orderService.listAllOrdersToDeliver()));

        return "adminAllDish";
    }

    @GetMapping("/adminFindDishByName")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminFindDishByName(@RequestParam(name = "name", required = false) String name,
                                      Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);
        model.addAttribute("foundDishesByName", dishService.listAllDishesByName(name));
        model.addAttribute("allDishes", dishService.listAllDishes());
        return "admin";
    }


    @PostMapping("/adminCreateDish")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminCreateDish(
            @RequestParam("file1") MultipartFile file1,
            @RequestParam("file2") MultipartFile file2,
            @RequestParam("file3") MultipartFile file3,
            @RequestParam("dishTypeId") Long dishTypeId,
            @RequestParam("cuisineId") Long cuisineId,
            Dish dish,
            RedirectAttributes redirectAttributes) throws IOException {

        try {
            // Получаем тип блюда и кухню по их ID
            DishType dishType = DishTypeRepository.findById(dishTypeId)
                    .orElseThrow(() -> new IllegalArgumentException("Тип блюда не найден"));
            Cuisine cuisine = CuisineRepository.findById(cuisineId)
                    .orElseThrow(() -> new IllegalArgumentException("Кухня не найдена"));

            // Присваиваем их объекту Dish
            dish.setDishType(dishType);
            dish.setCuisine(cuisine);

            // Сохраняем блюдо и изображения
            dishService.saveDish(dish, file1, file2, file3);
            redirectAttributes.addFlashAttribute("message", "Блюдо успешно сохранено");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при сохранении блюда");
        }

        return "redirect:/adminAddDish";
    }


    @PostMapping("/adminDeleteDish/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminDeleteDish(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            dishService.deleteDish(id);
            redirectAttributes.addFlashAttribute("message", "Блюдо успешно удалено");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при удалении букета");
        }
        return "redirect:/adminAllDish";
    }

    @GetMapping("/adminChoiceDish")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminChoiceDish(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        model.addAttribute("allDishes", dishService.listAllDishes());
        return "adminChoiceDish";
    }

    @PostMapping("adminChoiceDish")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminChoiceDish(@RequestParam List<Long> dishes){
        List<Dish> allDishes = dishService.listAllDishes();
        for(Dish dish : allDishes){
            dish.setInMenu(false);
            dishRepository.save(dish);
        }
        for(Long dishId : dishes){
            Dish dish = dishService.getDishByID(dishId);
            dish.setInMenu(true);
            dishRepository.save(dish);
        }
        return"redirect:/adminChoiceDish";
    }


    @GetMapping("/adminAddDish")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String addDish(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        return "adminAddDish";
    }


    @GetMapping("/adminOrderList")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminOrderList(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        List<Order> orders = orderService.listAllOrdersToDeliver();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o1.getDateDelivery().compareTo(o2.getDateDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));
        return "adminOrderList";
    }

    @GetMapping("/adminFinishedOrderList")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminFinishedOrderList(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        List<Order> orders = orderService.listOrdersFinished();

        List<Order> sortedOrders = orders.stream().sorted(Comparator.comparing(Order::getCourierDateTimeDelivery)).collect(Collectors.toList());

        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        return "adminFinishedOrderList";
    }

    @GetMapping("/adminAllEmployee")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminAllEmployee(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        model.addAttribute("allEmployee", userService.listAllEmployee());
        return "adminAllEmployee";
    }

    @GetMapping("/adminAddEmployee")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminAddEmployee(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);
        model.addAttribute("allUsers", userService.listAllUsersExceptAdmin());
        return "adminAddEmployee";
    }


    @PostMapping("/adminChangeRole")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminChangeRole(@RequestParam("id") Long userId, @RequestParam("role") String newRole, RedirectAttributes redirectAttributes) {
        User user = userService.getUserById(userId);
        if (user != null) {
            user.setRole(Role.valueOf(newRole));
            userService.save(user);
            redirectAttributes.addFlashAttribute("successMessage", "Роль пользователя успешно изменена.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Пользователь не найден.");
        }
        return "redirect:/adminAddEmployee";
    }




    @GetMapping("/adminAllUsers")
    public String adminAllUsers(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        model.addAttribute("allUsers", userService.listAllClient());
        return "adminAllUsers";
    }

}
