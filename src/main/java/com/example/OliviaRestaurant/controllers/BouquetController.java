package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.modelsOld.Bouquet;
import com.example.OliviaRestaurant.modelsOld.HomePage;
import com.example.OliviaRestaurant.modelsOld.Order;
import com.example.OliviaRestaurant.modelsOld.User;
import com.example.OliviaRestaurant.repositories.HomePageRepository;
import com.example.OliviaRestaurant.services.*;
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

@Controller

public class BouquetController {
    @Autowired
    private final BouquetService bouquetService;
    @Autowired
    private final OrderHasBouquetService orderHasBouquetService;
    @Autowired
    private final OrderService orderService;
    @Autowired
    private final PostcardService postcardService;
    @Autowired
    private final UserService userService;

    private final FavoriteService favoriteService;

    private final HomePageRepository homePageRepository;

    public BouquetController(BouquetService bouquetService, OrderHasBouquetService orderHasBouquetService, OrderService orderService, PostcardService postcardService, UserService userService, FavoriteService favoriteService, HomePageRepository homePageRepository) {
        this.bouquetService = bouquetService;
        this.orderHasBouquetService = orderHasBouquetService;
        this.orderService = orderService;
        this.postcardService = postcardService;

        this.userService = userService;
        this.favoriteService = favoriteService;
        this.homePageRepository = homePageRepository;
    }

    @GetMapping("/find_bouquet_by_name")
    public String bouquets(@RequestParam(name = "name", required = false) String name, Model model){
        model.addAttribute("foundBouquetsByName", bouquetService.listAllBouquetsByName(name));
        model.addAttribute("allBouquets", bouquetService.listAllBouquets());
        return "admin";
    }


    @GetMapping("/admin")
        public String admin(Model model){
        model.addAttribute("allBouquets", bouquetService.listAllBouquets());
        model.addAttribute("allPostcards", postcardService.listAllPostcards());
        model.addAttribute("toDeliverOrders", orderService.ListAllOrdersToDeliver());
        model.addAttribute("toDeliverBouquets", orderHasBouquetService.getPendingBouquets(orderService.ListAllOrdersToDeliver()));
        model.addAttribute("toDeliverAmounts", orderHasBouquetService.getPendingamount(orderService.ListAllOrdersToDeliver()));
        model.addAttribute("toDeliverPostcards", orderService.getPostCardToDelivery(orderService.ListAllOrdersToDeliver()));

        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);
        if (user != null){ model.addAttribute("isAdmin", user.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}

        return "admin";
    }



    /*@GetMapping("/getbouquetsbyorder/{id}")
    public String findbouquets(@PathVariable Long id, Model model){
        Order order = orderService.getOrderByID(id);
        model.addAttribute("bouquetsorderful",orderHasBouquetService.getbouquetsByOrder(order));
        model.addAttribute("amountsorderful",orderHasBouquetService.getAmountsByOrder(order));
        return "admin";
    }*/



    @GetMapping("/bouquet/{id}")
    public String bouquet(@PathVariable Long id, Model model){
        Bouquet bouquet = bouquetService.getBouquetByID(id);
        model.addAttribute("bouquet", bouquet);

        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);
        if (user != null){
            model.addAttribute("isAdmin", user.getIsAdministrator());
            List<Bouquet> bouquetList = orderHasBouquetService.getbouquetsByOrder(orderService.HaveOrderInCardByUser(user));

            // Проверяем наличие нужного id букета в списке
            boolean bouquetExists = false;
            for (Bouquet bouquetB : bouquetList) {
                if (Objects.equals(bouquetB.getId(), id)) {
                    bouquetExists = true;
                    break;
                }
            }
            if (bouquetExists) {
                model.addAttribute("inCard", true);
            } else {
                model.addAttribute("inCard", false);
            }

            List<Bouquet> favouriteList = favoriteService.getFavoriteBouquetsByUser(user);

            boolean favBouquetExists = false;
            for (Bouquet bouquetB : favouriteList) {
                if (Objects.equals(bouquetB.getId(), id)) {
                    favBouquetExists = true;
                    break;
                }
            }

            if (favBouquetExists) {
                model.addAttribute("inFav", true);
            } else {
                model.addAttribute("inFav", false);
            }
        }
        else{
            model.addAttribute("isAdmin", false);
            model.addAttribute("inCard", false);
            model.addAttribute("inFav", false);
        }
        return "bouquet";
    }

    @PostMapping("/bouquet_create")
    public String createBouquet(@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2,
                                              @RequestParam("file3") MultipartFile file3, Bouquet bouquet,
                                              RedirectAttributes redirectAttributes) throws IOException {
        try {
            bouquetService.saveBouquet(bouquet, file1, file2, file3);


            redirectAttributes.addFlashAttribute("message", "Букет успешно сохранен");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при сохранении букета");
        }
        return "redirect:/adminaddbouquet";
    }


    @PostMapping("/bouquet_delete/{id}")
    public String deleteBouquet(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            bouquetService.deleteBouquet(id);
            redirectAttributes.addFlashAttribute("message", "Букет успешно удален");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при удалении букета");
        }
        return "redirect:/admin";
    }

    @PostMapping("/bouquet_addcar/{id}")
    public String addToCart(@PathVariable Long id, Principal principal, RedirectAttributes redirectAttributes) {
        try{
            //проверка пользователя администратор он или нет
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
            String username = authentication.getName(); // Получить имя пользователя
            User user = userService.getUserByEmail(username);
            if (user != null){
                List<Bouquet> bouquetList = orderHasBouquetService.getbouquetsByOrder(orderService.HaveOrderInCardByUser(user));

                // Проверяем наличие нужного id букета в списке
                boolean bouquetExists = false;
                for (Bouquet bouquetB : bouquetList) {
                    if (Objects.equals(bouquetB.getId(), id)) {
                        bouquetExists = true;
                        break;
                    }
                }

                if (bouquetExists) {
                    redirectAttributes.addFlashAttribute("warning", "Букет уже в корзине");
                } else {
                    Bouquet bouquet = bouquetService.getBouquetByID(id);
                    orderHasBouquetService.createOrderHasBouquet(bouquet, principal);
                    redirectAttributes.addFlashAttribute("message", "Успешно добавлено в корзину");
                }
            }

        }catch (Exception e){
            redirectAttributes.addFlashAttribute("error", "Ошибка при добавлении в корзину");
        }
        return "redirect:/bouquet/{id}";
    }

    @PostMapping("deliver_order/{id}")
    public String finishOrder(@PathVariable Long id, RedirectAttributes redirectAttributes){
        try{
            Order order = orderService.getOrderByID(id);
            order.setStatus("Доставлен");
            orderService.saveOrder(order);
            redirectAttributes.addFlashAttribute("message", "Заказ доставлен");
        } catch(Exception e){
            redirectAttributes.addFlashAttribute("message", "Ошибка при доставке заказа");
        }

        return"redirect:/adminorderlist";
    }

    @PostMapping("cancel_order/{id}")
    public String cancelOrder(@PathVariable Long id, RedirectAttributes redirectAttributes){
        try{
            Order order = orderService.getOrderByID(id);
            orderService.CancelOrder(order);

            redirectAttributes.addFlashAttribute("message", "Заказ отменён");
        }catch(Exception e){
            redirectAttributes.addFlashAttribute("message", "Ошибка при отмене заказа");
        }

        return"redirect:/adminorderlist";
    }

    @GetMapping("/adminaddbouquet")
    public String addbouq(Model model){
        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);
        if (user != null){ model.addAttribute("isAdmin", user.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}
        return "adminaddbouquet";
    }

    @GetMapping("/adminchoicebouquet")
    public String chobouq(Model model){
        // Получить все записи о букетах на главной странице из базы данных
        List<HomePage> homePageBouquets = homePageRepository.findAll();

        if (homePageBouquets.size() == 3) {

            Bouquet bouquet1 = homePageBouquets.get(0).getBouquet();
            Bouquet bouquet2 = homePageBouquets.get(1).getBouquet();
            Bouquet bouquet3 = homePageBouquets.get(2).getBouquet();

            model.addAttribute("bouquet1", bouquet1.getId());
            model.addAttribute("bouquet2", bouquet2.getId());
            model.addAttribute("bouquet3", bouquet3.getId());

            String description1 = homePageBouquets.get(0).getDescription();
            String description2 = homePageBouquets.get(1).getDescription();
            String description3 = homePageBouquets.get(2).getDescription();

            model.addAttribute("description1", description1);
            model.addAttribute("description2", description2);
            model.addAttribute("description3", description3);
        }
        else{
            model.addAttribute("bouquet1", "");
            model.addAttribute("bouquet2", "");
            model.addAttribute("bouquet3", "");
            model.addAttribute("description1", "");
            model.addAttribute("description2", "");
            model.addAttribute("description3", "");
        }


        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);
        if (user != null){ model.addAttribute("isAdmin", user.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}
        return "adminchoicebouquet";
    }

    @GetMapping("/adminorderlist")
    public String lisordr(Model model){
        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);
        if (user != null){ model.addAttribute("isAdmin", user.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}

        List<Order> orders = orderService.ListAllOrdersToDeliver();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o1.getDateDelivery().compareTo(o2.getDateDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverBouquets", orderHasBouquetService.getPendingBouquets(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasBouquetService.getPendingamount(sortedOrders));
        model.addAttribute("toDeliverPostcards", orderService.getPostCardToDelivery(sortedOrders));
        return "adminorderlist";
    }

    @GetMapping("/adminFinishedOrderList")
    public String adminFinishedOrderList(Model model){
        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);
        if (user != null){ model.addAttribute("isAdmin", user.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}

        List<Order> orders = orderService.ListOrdersFinished();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o2.getDateDelivery().compareTo(o1.getDateDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverBouquets", orderHasBouquetService.getPendingBouquets(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasBouquetService.getPendingamount(sortedOrders));
        model.addAttribute("toDeliverPostcards", orderService.getPostCardToDelivery(sortedOrders));

        return "adminFinishedOrderList";
    }

    @GetMapping("/adminCanceledOrderList")
    public String adminCanceledOrderList(Model model){
        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);
        if (user != null){ model.addAttribute("isAdmin", user.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}

        List<Order> orders = orderService.ListOrdersCanceled();

        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o2.getDateDelivery().compareTo(o1.getDateDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverBouquets", orderHasBouquetService.getPendingBouquets(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasBouquetService.getPendingamount(sortedOrders));
        model.addAttribute("toDeliverPostcards", orderService.getPostCardToDelivery(sortedOrders));


        return "adminCanceledOrderList";
    }

    @GetMapping("/adminpostcard")
    public String postcrd(Model model){
        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);
        if (user != null){ model.addAttribute("isAdmin", user.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}

        model.addAttribute("allPostcards", postcardService.listAllPostcards());
        return "/adminpostcard";
    }

    @GetMapping("/adminAllUsers")
    public String adminAllUsers(Model model){
        model.addAttribute("allUsers", userService.listAllUsers());

        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);
        if (user != null){ model.addAttribute("isAdmin", user.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}

        return "adminAllUsers";
    }


}
