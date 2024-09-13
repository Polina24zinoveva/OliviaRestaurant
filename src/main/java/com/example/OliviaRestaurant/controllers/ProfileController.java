package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Bouquet;
import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Controller
public class ProfileController {

    private final FavoriteService favoriteService;
    private final BouquetService bouquetService;
    private final UserService userService;
    private final OrderService orderService;
    private final PostcardService postcardService;
    private final OrderHasBouquetService orderHasBouquetService;
    @Autowired
    public ProfileController(FavoriteService favoriteService, BouquetService bouquetService, UserService userService, OrderService orderService, PostcardService postcardService, OrderHasBouquetService orderHasBouquetService) {
        this.favoriteService = favoriteService;
        this.bouquetService = bouquetService;
        this.userService = userService;
        this.orderService = orderService;
        this.postcardService = postcardService;
        this.orderHasBouquetService = orderHasBouquetService;
    }

    @GetMapping("/profile")
    public String profile(Model model, @AuthenticationPrincipal User user) {
        List<Order> orders = orderService.ListOrdersActive(user); // Получаем заказы пользователя
        // Сортируем заказы по дате доставки
        List<Order> sortedOrders = orders.stream()
                .sorted((o1, o2) -> o1.getDateDelivery().compareTo(o2.getDateDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("currentUser", user);
        model.addAttribute("toDeliverOrders", sortedOrders);
        model.addAttribute("toDeliverBouquets", orderHasBouquetService.getPendingBouquets(sortedOrders));
        model.addAttribute("toDeliverAmounts", orderHasBouquetService.getPendingamount(sortedOrders));
        model.addAttribute("toDeliverPostcards", orderService.getPostCardToDelivery(sortedOrders));

        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user1 = userService.getUserByEmail(username);
        if (user1 != null){ model.addAttribute("isAdmin", user1.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}

        return "profile";
    }

    @GetMapping("/historyOrders")
    public String historyOrders(Model model, @AuthenticationPrincipal User user) {
        List<Order> finishedOrders = orderService.ListOrdersFinished(user); // Получаем заказы пользователя
        // Сортируем заказы по дате доставки
        List<Order> sortedFinishedOrders = finishedOrders.stream()
                .sorted((o1, o2) -> o2.getDateDelivery().compareTo(o1.getDateDelivery()))
                .collect(Collectors.toList());

        model.addAttribute("finishedOrders", sortedFinishedOrders);
        model.addAttribute("toDeliverBouquets", orderHasBouquetService.getPendingBouquets(sortedFinishedOrders));
        model.addAttribute("toDeliverAmounts", orderHasBouquetService.getPendingamount(sortedFinishedOrders));
        model.addAttribute("toDeliverPostcards", orderService.getPostCardToDelivery(sortedFinishedOrders));
        model.addAttribute("currentUser", user);

        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user1 = userService.getUserByEmail(username);
        if (user1 != null){ model.addAttribute("isAdmin", user1.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}

        return "historyOrders";
    }

    @PostMapping("/add_to_favorites")
    @PreAuthorize("isAuthenticated()")
    public String addToFavorites(@RequestParam Long bouquetId, @AuthenticationPrincipal User user, RedirectAttributes redirectAttributes) {
        List<Bouquet> favouriteList = favoriteService.getFavoriteBouquetsByUser(user);

        boolean favBouquetExists = favouriteList.stream()
                .anyMatch(bouquetB -> Objects.equals(bouquetB.getId(), bouquetId));

        if (favBouquetExists) {
            redirectAttributes.addFlashAttribute("warning", "Букет уже в избранном");
        } else {
            Bouquet bouquet = bouquetService.getBouquetByID(bouquetId);
            favoriteService.saveFavorite(user, bouquet);
            redirectAttributes.addFlashAttribute("message", "Успешно добавлено в избранное");
        }

        // Включаем bouquetId в URL перенаправления
        return "redirect:/bouquet/" + bouquetId;
    }


}
