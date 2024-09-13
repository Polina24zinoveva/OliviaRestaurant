package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Bouquet;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.services.FavoriteService;
import com.example.OliviaRestaurant.services.UserService;
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

@Controller
public class FavoriteController {
    private final FavoriteService favoriteService;

    private final UserService userService;

    public FavoriteController(FavoriteService favoriteService, UserService userService) {
        this.favoriteService = favoriteService;
        this.userService = userService;
    }

    @GetMapping("/favorite")
    public String profile(Model model, @AuthenticationPrincipal User user) {
        List<Bouquet> favoriteBouquets = favoriteService.getFavoriteBouquetsByUser(user);
        model.addAttribute("favoriteBouquets", favoriteBouquets);
        model.addAttribute("currentUser", user);

        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user1 = userService.getUserByEmail(username);
        if (user1 != null){ model.addAttribute("isAdmin", user1.getIsAdministrator());}
        else{ model.addAttribute("isAdmin", false);}

        return "favorite";
    }

    @PostMapping("/remove_from_favorites")
    public String removeFromFavorites(@RequestParam Long bouquetId, @RequestParam Long userId, RedirectAttributes redirectAttributes) {
        favoriteService.removeFromFavorites(bouquetId, userId);
        redirectAttributes.addFlashAttribute("message", "Успешно удалено из избранного");
        return "redirect:/favorite";
    }

    @PostMapping("/remove_from_favorites_without_user")
    public String removeFromFavoritesWithoutUser(@RequestParam Long bouquetId, RedirectAttributes redirectAttributes) {
        //проверка пользователя администратор он или нет
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
        String username = authentication.getName(); // Получить имя пользователя
        User user = userService.getUserByEmail(username);

        favoriteService.removeFromFavorites(bouquetId, user.getId());
        redirectAttributes.addFlashAttribute("message", "Успешно удалено из избранного");
        return "redirect:/bouquet/" + bouquetId;
    }
}
