package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.*;
import com.example.OliviaRestaurant.repositories.CuisineRepository;
import com.example.OliviaRestaurant.repositories.DishTypeRepository;
import com.example.OliviaRestaurant.repositories.ImageRepository;
import com.example.OliviaRestaurant.services.DishService;
import com.example.OliviaRestaurant.services.OrderHasDishService;
import com.example.OliviaRestaurant.services.OrderService;
import com.example.OliviaRestaurant.services.UserService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
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


    @GetMapping("/adminAllDish")
    public String admin(Model model){
        model.addAttribute("allDishes", dishService.listAllDishes());
        model.addAttribute("toDeliverOrders", orderService.ListAllOrdersToDeliver());
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(orderService.ListAllOrdersToDeliver()));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingDishes(orderService.ListAllOrdersToDeliver()));

        return "adminAllDish";
    }

    @GetMapping("/adminFindDishByName")
    public String adminFindDishByName(@RequestParam(name = "name", required = false) String name, Model model){
        model.addAttribute("foundDishesByName", dishService.listAllDishesByName(name));
        model.addAttribute("allDishes", dishService.listAllDishes());
        return "admin";
    }


    @PostMapping("/adminCreateDish")
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
    public String adminDeleteDish(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            dishService.deleteDish(id);
            redirectAttributes.addFlashAttribute("message", "Блюдо успешно удалено");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при удалении букета");
        }
        return "redirect:/adminAllDish";
    }

    @PostMapping("/addToCartDish/{id}")
    public String addToCartDish(@PathVariable Long id, Principal principal, RedirectAttributes redirectAttributes) {
        try{
            //проверка пользователя администратор он или нет
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
            String username = authentication.getName(); // Получить имя пользователя
            User user = userService.getUserByEmail(username);
            if (user != null){
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
                    redirectAttributes.addFlashAttribute("warning", "Блюдо уже в корзине");
                } else {
                    Dish dish = dishService.getDishByID(id);
                    orderHasDishService.createOrderHasDish(dish, principal);
                    redirectAttributes.addFlashAttribute("message", "Успешно добавлено в корзину");
                }
            }

        }catch (Exception e){
            redirectAttributes.addFlashAttribute("error", "Ошибка при добавлении в корзину");
        }
        return "redirect:/dish/{id}";
    }

    @PostMapping("adminFinishOrder/{id}")
    public String adminFinishOrder(@PathVariable Long id, RedirectAttributes redirectAttributes){
        try{
            Order order = orderService.getOrderByID(id);
            order.setStatus("Доставлен");
            orderService.saveOrder(order);
            redirectAttributes.addFlashAttribute("message", "Заказ доставлен");
        } catch(Exception e){
            redirectAttributes.addFlashAttribute("message", "Ошибка при доставке заказа");
        }

        return"redirect:/adminOrderList";
    }

    @PostMapping("adminCancelOrder/{id}")
    public String adminCancelOrder(@PathVariable Long id, RedirectAttributes redirectAttributes){
        try{
            Order order = orderService.getOrderByID(id);
            orderService.CancelOrder(order);

            redirectAttributes.addFlashAttribute("message", "Заказ отменён");
        }catch(Exception e){
            redirectAttributes.addFlashAttribute("message", "Ошибка при отмене заказа");
        }

        return"redirect:/adminOrderList";
    }

    @GetMapping("/adminAddDish")
    public String addDish(Model model){

        return "adminAddDish";
    }


    @GetMapping("/adminOrderList")
    public String adminOrderList(Model model){
        List<Order> orders = orderService.ListAllOrdersToDeliver();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o1.getDateTimeDelivery().compareTo(o2.getDateTimeDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));
        return "adminOrderList";
    }

    @GetMapping("/adminFinishedOrderList")
    public String adminFinishedOrderList(Model model){
        List<Order> orders = orderService.ListOrdersFinished();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o2.getDateTimeDelivery().compareTo(o1.getDateTimeDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        return "adminFinishedOrderList";
    }

    @GetMapping("/adminCanceledOrderList")
    public String adminCanceledOrderList(Model model){
        List<Order> orders = orderService.ListOrdersCanceled();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o2.getDateTimeDelivery().compareTo(o1.getDateTimeDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        return "adminCanceledOrderList";
    }

    @GetMapping("/adminAllUsers")
    public String adminAllUsers(Model model){
        model.addAttribute("allUsers", userService.listAllUsers());
        return "adminAllUsers";
    }
}
