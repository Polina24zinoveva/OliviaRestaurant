package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.*;
import com.example.OliviaRestaurant.models.enums.OrderStatus;
import com.example.OliviaRestaurant.models.enums.Role;
import com.example.OliviaRestaurant.repositories.*;
import com.example.OliviaRestaurant.services.DishService;
import com.example.OliviaRestaurant.services.OrderHasDishService;
import com.example.OliviaRestaurant.services.OrderService;
import com.example.OliviaRestaurant.services.UserService;
import com.example.OliviaRestaurant.statics.StaticMethods;
import jakarta.transaction.Transactional;
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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;
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
    private final OrderRepository orderRepository;
    private final OrderHasDishRepository orderHasDishRepository;
    private final UserRepository userRepository;


    @GetMapping("/adminAllDishes")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminAllDishes(Model model, @AuthenticationPrincipal User user,
                                   @RequestParam(name = "dishTypeId", required = false, defaultValue = "0") String dishTypeId,
                               @RequestParam(name = "cuisineId", required = false, defaultValue = "0") String cuisineId){
        StaticMethods.header(user, model);

        List<Dish> allDishes = dishService.listAllDishes();

        switch (dishTypeId){
            case "0":
                break;
            case "1":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 1).toList();
                break;
            case "2":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 2).toList();
                break;
            case "3":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 3).toList();
                break;
            case "4":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 4).toList();
                break;
            case "5":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 5).toList();
                break;
            case "6":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 6).toList();
                break;
            case "7":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 7).toList();
                break;
            case "8":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 8).toList();
                break;
            case "9":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 9).toList();
                break;
            case "10":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 10).toList();
                break;
            case "11":
                allDishes = allDishes.stream().filter(dish -> dish.getDishType().getId() == 11).toList();
                break;
        }

        switch (cuisineId){
            case "0":
                break;
            case "1":
                allDishes = allDishes.stream().filter(dish -> dish.getCuisine().getId() == 1).toList();
                break;
            case "2":
                allDishes = allDishes.stream().filter(dish -> dish.getCuisine().getId() == 2).toList();
                break;
            case "3":
                allDishes = allDishes.stream().filter(dish -> dish.getCuisine().getId() == 3).toList();
                break;
            case "4":
                allDishes = allDishes.stream().filter(dish -> dish.getCuisine().getId() == 4).toList();
                break;

        }


        model.addAttribute("allDishes", allDishes);
        model.addAttribute("dishTypeId", dishTypeId);
        model.addAttribute("cuisineId", cuisineId);

        return "adminAllDishes";
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
            dish.setDeleted(false);

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
    @Transactional
    public String adminDeleteDish(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        //проверяем наличие заказов с блюдом
        List<Order> ordersWithDish = orderRepository.findActiveOrdersByDishId(id, OrderStatus.STATUS_DELIVERED);

        List<Order> ordersInCard = new ArrayList<>();

        // Если есть заказы с этим блюдом, проверяем статусы
        if (!ordersWithDish.isEmpty()) {
            for (Order order : ordersWithDish) {
                if (order.getStatus() == OrderStatus.STATUS_IN_CART) {
                    ordersInCard.add(order);
                }
                else{
                    redirectAttributes.addFlashAttribute("error", "Блюдо используется в заказах. Подождите доставки этих заказов");
                    return "redirect:/adminAllDishes";
                }
            }
        }

        // Если блюдо находится в корзинах, удаляем его и пересчитываем сумму заказов
        if (!ordersInCard.isEmpty()) {
            for (Order order: ordersInCard){
                Dish dish = dishRepository.findById(id).orElse(null);
                OrderHasDish orderHasDish = orderHasDishRepository.findByDishAndOrder(dish, order);

                // Уменьшаем общую сумму заказа на стоимость удаляемого блюда
                Double delta = orderHasDish.getCount() * dish.getPrice();
                order.setTotalPrice(order.getTotalPrice() - delta);

                // Удаляем запись блюда из заказа
                orderHasDishRepository.delete(orderHasDish);

                // Если заказ пустой, удаляем сам заказ
                if (orderHasDishRepository.findAllByOrder(order).isEmpty()) {
                    orderRepository.deleteById(order.getId());
                } else {
                    // Иначе сохраняем изменения в заказе
                    orderRepository.save(order);
                }
            }
        }

        Dish dish = dishRepository.findById(id).orElse(null);

        if (dish != null) {
            dish.setDeleted(true);
            dish.setInMenu(false);
            dishRepository.save(dish);
            redirectAttributes.addFlashAttribute("message", "Блюдо успешно удалено");
        }
        else {
            redirectAttributes.addFlashAttribute("error", "Блюдо используется в заказах со статусом 'Оплачено' или 'На доставке'.");
        }


        return "redirect:/adminAllDishes";
    }

    @GetMapping("/adminEditDish/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminEditDishGet(@PathVariable Long id, Model model) {
        model.addAttribute("dish", dishService.getDishByID(id));
        return "adminEditDish";
    }

    @PostMapping("/adminEditDish/{id}")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminEditDish(@RequestParam("dishTypeId") Long dishTypeId,
                                @RequestParam("cuisineId") Long cuisineId,
                                Dish dish,
                                RedirectAttributes redirectAttributes) throws IOException {

        try {
            //Dish dish1 = dishRepository.findById(dish.getId()).orElseThrow();

            // Получаем тип блюда и кухню по их ID
            DishType dishType = DishTypeRepository.findById(dishTypeId)
                    .orElseThrow(() -> new IllegalArgumentException("Тип блюда не найден"));
            Cuisine cuisine = CuisineRepository.findById(cuisineId)
                    .orElseThrow(() -> new IllegalArgumentException("Кухня не найдена"));

            // Присваиваем их объекту Dish
            dish.setDishType(dishType);
            dish.setCuisine(cuisine);

            dishRepository.save(dish);
            redirectAttributes.addFlashAttribute("message", "Блюдо успешно отредактировано");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при редактировании блюда");
        }
        return "redirect:/adminAllDishes";
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
    public String adminChoiceDish(@RequestParam List<Long> dishes, RedirectAttributes redirectAttributes){
        try {
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
            redirectAttributes.addFlashAttribute("message", "Блюда успешно добавлены в меню");

        }
        catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка в добавлении блюд в меню");
        }

        return"redirect:/adminChoiceDish";
    }


    @GetMapping("/adminAddDish")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String addDish(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        if (dishService.listAllDishes().size() > 100){
            model.addAttribute("banOfAdding", "Нельзя иметь более 100 блюд");
        }

        return "adminAddDish";
    }


    @GetMapping("/adminOrderList")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminOrderList(Model model, @AuthenticationPrincipal User user){
        StaticMethods.header(user, model);

        List<Order> orders = orderService.listAllOrdersToDeliver();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream().sorted(Comparator.comparing(Order::getDateDelivery)
                        .thenComparing(order -> LocalTime.parse(order.getTimeDelivery())))
                .collect(Collectors.toList());

        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverDishes", orderHasDishService.getPendingDishes(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasDishService.getPendingAmount(sortedOrders));

        model.addAttribute("datesDelivery", orderHasDishService.getDatesDelivery(sortedOrders));
        model.addAttribute("datesTimePayment", orderHasDishService.getDatesTimePayment(sortedOrders));
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

        model.addAttribute("datesDelivery", orderHasDishService.getDatesDelivery(sortedOrders));
        model.addAttribute("datesTimePayment", orderHasDishService.getDatesTimePayment(sortedOrders));
        model.addAttribute("courierDatesTimeDelivery", orderHasDishService.getCourierDatesTimeDelivery(sortedOrders));
        return "adminFinishedOrderList";
    }

    @GetMapping("/adminAllEmployee")
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String adminAllEmployee(Model model, @AuthenticationPrincipal User user,
                                   @RequestParam(name = "role", required = false, defaultValue = "all") String role,
                                   @RequestParam(name = "searchField", required = false, defaultValue = "") String searchField,
                                   @RequestParam(name = "searchQuery", required = false, defaultValue = "") String searchQuery,
                                   RedirectAttributes redirectAttributes){
        StaticMethods.header(user, model);

        List<User> employees = new ArrayList<>();
        switch (role){
            case "all":
                employees = userService.listAllEmployee();
                break;
            case "ROLE_MANAGER":
                employees = userService.listAllManagers();
                break;
            case "ROLE_COURIER":
                employees = userService.listAllCouriers();
                break;
        }

        switch (searchField){
            case "id":
                try {
                    Long id = Long.parseLong(searchQuery);
                    employees = userRepository.findAllById(Collections.singleton(id));
                }
                catch (Exception e){
                    model.addAttribute("error", "Некорректный запрос для id");
                    searchQuery="Введите значение для поиска";
                }
                break;
            case "name":
                employees = userRepository.findByNameContainingIgnoreCase(searchQuery);
                break;
            case "surname":
                employees = userRepository.findBySurnameContainingIgnoreCase(searchQuery);
                break;
            case "nameAndSurname":
                String[] nameAndSurname = searchQuery.split(" ");
                String name = nameAndSurname[0];
                String surname = nameAndSurname.length > 1 ? nameAndSurname[1] : "";

                employees = userRepository.findByNameContainingIgnoreCase(name).stream()
                        .filter(e -> e.getSurname().equalsIgnoreCase(surname))
                        .collect(Collectors.toList());
                break;
            case "phoneNumber":
                employees.clear();
                employees.add(userRepository.findByPhoneNumberContaining(searchQuery));
                break;
            case "email":
                employees.clear();
                employees.add(userRepository.findByEmailContaining(searchQuery));
                break;
            default:
                searchQuery="Введите значение для поиска";
        }

        employees = employees.stream()
                .filter(e -> e.getRole() != Role.ROLE_ADMIN && e.getRole() != Role.ROLE_USER)
                .collect(Collectors.toList());

        model.addAttribute("allEmployee", employees);
        model.addAttribute("role", role);
        model.addAttribute("searchQuery", searchQuery);

        if (searchField == ""){
            model.addAttribute("searchField", "id");
        }
        else model.addAttribute("searchField", searchField);
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
            redirectAttributes.addFlashAttribute("message", "Роль пользователя успешно изменена");
        } else {
            redirectAttributes.addFlashAttribute("error", "Пользователь не найден");
        }
        return "redirect:/adminAddEmployee";
    }




    @GetMapping("/adminAllUsers")
    public String adminAllUsers(Model model, @AuthenticationPrincipal User user,
                                @RequestParam(name = "searchField", required = false, defaultValue = "") String searchField,
                                @RequestParam(name = "searchQuery", required = false, defaultValue = "") String searchQuery){
        StaticMethods.header(user, model);

        List<User> users = userService.listAllClient();

        switch (searchField){
            case "id":
                try {
                    Long id = Long.parseLong(searchQuery);
                    users = userRepository.findAllById(Collections.singleton(id));
                }
                catch (Exception e){
                    model.addAttribute("error", "Некорректный запрос для id");
                    searchQuery="Введите значение для поиска";
                }
                break;
            case "name":
                users = userRepository.findByNameContainingIgnoreCase(searchQuery);
                break;
            case "surname":
                users = userRepository.findBySurnameContainingIgnoreCase(searchQuery);
                break;
            case "nameAndSurname":
                String[] nameAndSurname = searchQuery.split(" ");
                String name = nameAndSurname[0];
                String surname = nameAndSurname.length > 1 ? nameAndSurname[1] : "";

                users = userRepository.findByNameContainingIgnoreCase(name).stream()
                        .filter(e -> e.getSurname().equalsIgnoreCase(surname))
                        .collect(Collectors.toList());
                break;
            case "phoneNumber":
                users.clear();
                users.add(userRepository.findByPhoneNumberContaining(searchQuery));
                break;
            case "email":
                users.clear();
                users.add(userRepository.findByEmailContaining(searchQuery));
                break;
            default:
                searchQuery="Введите значение для поиска";
        }

        users = users.stream()
                .filter(e -> e.getRole() == Role.ROLE_USER)
                .collect(Collectors.toList());

        if (searchField == ""){
            model.addAttribute("searchField", "id");
        }
        else model.addAttribute("searchField", searchField);

        model.addAttribute("searchQuery", searchQuery);

        model.addAttribute("allUsers", users);
        return "adminAllUsers";
    }

}
