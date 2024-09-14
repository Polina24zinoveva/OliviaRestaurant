package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.modelsOld.Bouquet;
import com.example.OliviaRestaurant.modelsOld.HomePage;
import com.example.OliviaRestaurant.modelsOld.User;
import com.example.OliviaRestaurant.repositories.HomePageRepository;
import com.example.OliviaRestaurant.services.BouquetService;
import com.example.OliviaRestaurant.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;


@Controller
public class HomePageController {

    @Autowired
    private final BouquetService bouquetService;

    @Autowired
    private final UserService userService;

    @Autowired
    private final HomePageRepository homePageRepository;

    public HomePageController(BouquetService bouquetService, UserService userService, HomePageRepository homePageRepository) {
        this.bouquetService = bouquetService;
        this.userService = userService;
        this.homePageRepository = homePageRepository;
    }

    @GetMapping("/")
    public String home(Model model){

        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && authentication.isAuthenticated()) {
                // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
                String username = authentication.getName(); // Получить имя пользователя
                User user = userService.getUserByEmail(username);
                if (user != null){ model.addAttribute("isAdmin", user.getIsAdministrator());}
                else{ model.addAttribute("isAdmin", false);}
            }


            // Получить все записи о букетах на главной странице из базы данных
            List<HomePage> homePageBouquets = homePageRepository.findAll();

            // Поместить полученные букеты в модель
            model.addAttribute("homePageBouquets", homePageBouquets);

            if (homePageBouquets.size() == 3) {
                Bouquet bouquet1 = homePageBouquets.get(0).getBouquet();
                Bouquet bouquet2 = homePageBouquets.get(1).getBouquet();
                Bouquet bouquet3 = homePageBouquets.get(2).getBouquet();

                model.addAttribute("bouquet1", bouquet1);
                model.addAttribute("bouquet2", bouquet2);
                model.addAttribute("bouquet3", bouquet3);


            } else {
                // Логика для обработки случая, когда список пустой
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        // Вернуть страницу главного экрана
        return "home";
    }


    @PostMapping("/add_bouquets_to_homepage")
    public String addBouquetsToHomepage(@RequestParam(name = "bouquet1", required = false) Long bouquetId1, @RequestParam(name = "description1", required = false) String description1,
                                        @RequestParam(name = "bouquet2", required = false) Long bouquetId2, @RequestParam(name = "description2", required = false) String description2,
                                        @RequestParam(name = "bouquet3", required = false) Long bouquetId3, @RequestParam(name = "description3", required = false) String description3,
                                        Model model, RedirectAttributes redirectAttributes) {
        if (bouquetId1 != null && bouquetId2 != null && bouquetId3 != null
            && description1 != null && description2 != null && description3 != null) {
            homePageRepository.deleteAll();

            // Получить информацию о букетах с переданными ID и добавить её в модель
            Bouquet bouquet1 = bouquetService.getBouquetByID(bouquetId1);
            Bouquet bouquet2 = bouquetService.getBouquetByID(bouquetId2);
            Bouquet bouquet3 = bouquetService.getBouquetByID(bouquetId3);


            // Создать новую запись для главной страницы и сохранить её в базе данных
            HomePage homePage1 = new HomePage();
            homePage1.setBouquet(bouquet1);
            homePage1.setDescription(description1);
            homePageRepository.save(homePage1);

            HomePage homePage2 = new HomePage();
            homePage2.setBouquet(bouquet2);
            homePage2.setDescription(description2);
            homePageRepository.save(homePage2);

            HomePage homePage3 = new HomePage();
            homePage3.setBouquet(bouquet3);
            homePage3.setDescription(description3);
            homePageRepository.save(homePage3);
            redirectAttributes.addFlashAttribute("message", "Успешно добавлено на главный экран");

        } else {
            redirectAttributes.addFlashAttribute("error", "Вы заполнили не все данные. Операция отклонена.");
        }
        return "redirect:/adminchoicebouquet";


    }
}
