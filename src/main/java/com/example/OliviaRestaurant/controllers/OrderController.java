package com.example.OliviaRestaurant.controllers;

import com.example.OliviaRestaurant.models.Bouquet;
import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Controller
public class OrderController {
    @Autowired
    public final OrderService orderService;
    @Autowired
    public final OrderHasBouquetService orderHasBouquetService;

    @Autowired
    private final PostcardService postcardService;

    @Autowired
    private final UserService userService;


    @Autowired
    private BouquetService bouquetService;

    public OrderController(OrderService orderService, OrderHasBouquetService orderHasBouquetService,
                           PostcardService postcardService, UserService userService) {
        this.orderService = orderService;
        this.orderHasBouquetService = orderHasBouquetService;
        this.postcardService = postcardService;
        this.userService = userService;
    }

//    @GetMapping("/order")
//    public String order(){
//        return "order";
//    }

    @GetMapping("/order/add")
    public String addOrder(Order order, Principal principal) throws IOException {
        orderService.saveOrder(principal, order);
        return "redirect:/order";
    }

    @GetMapping("/getorders")
    public String getOrders(Principal principal, Model model){
        model.addAttribute("orders", orderService.ListOrders());
        model.addAttribute("user", orderService.getUserByPrincipal(principal));
        return "order";
    }

    @GetMapping("/order")
    public String getBouqordersAc(Principal principal,Model model){
        try {

            // Получение текущей даты
            LocalDate minDate = LocalDate.now();

            // Получение текущей даты плюс три месяца
            LocalDate maxDate = minDate.plus(3, ChronoUnit.MONTHS);

            int hourNow = LocalTime.now().getHour();
            if(hourNow >= 20){
                minDate = minDate.plus(1, ChronoUnit.DAYS);
            }


            model.addAttribute("acBouquets", orderHasBouquetService.getbouquetsByOrder(orderService.HaveOrderInCardByPrincipal(principal)));

            model.addAttribute("inacOrders", orderService.ListOrdersInactive(principal));
            model.addAttribute("acAmounts", orderHasBouquetService.getAmountsByOrder(orderService.HaveOrderInCardByPrincipal(principal)));
            List<Long> acAmounts = orderHasBouquetService.getAmountsByOrder(orderService.HaveOrderInCardByPrincipal(principal));
            Long countBouquetsInOrder = 0L;
            for(int i = 0; i < acAmounts.size(); i++){
                countBouquetsInOrder += acAmounts.get(i);
            }
            String countBouquetsInOrderString = "";
            if (countBouquetsInOrder == 1){ countBouquetsInOrderString = "1 букет";}
            else if (countBouquetsInOrder >= 2 && countBouquetsInOrder <= 4){countBouquetsInOrderString = countBouquetsInOrder + " букета";}
            else {countBouquetsInOrderString = countBouquetsInOrder + " букетов";}

            model.addAttribute("countBouquetsInOrderString", countBouquetsInOrderString);

            model.addAttribute("acOrder", orderService.HaveOrderInCardByPrincipal(principal));
            model.addAttribute("allPostcards", postcardService.listAllPostcards());

            // Получение пользователя из базы данных по его email (имени пользователя)
            User user = userService.getUserByEmail(principal.getName());

            // Передача номера телефона в модель
            model.addAttribute("phoneNumber", user.getPhoneNumber());

            model.addAttribute("minDate", minDate);
            model.addAttribute("maxDate", maxDate);


            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && authentication.isAuthenticated()) {
                // Пользователь аутентифицирован, можно получить его имя пользователя или другой идентификатор
                String username = authentication.getName(); // Получить имя пользователя
                User user1 = userService.getUserByEmail(username);
                model.addAttribute("isAdmin", user1.getIsAdministrator());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "order";
    }

    @PostMapping("/order_delete/{id}")
    public String deleteOrderBouquet(@PathVariable Long id, Principal principal, RedirectAttributes redirectAttributes){
        try {
            Bouquet bouquet = bouquetService.getBouquetByID(id);
            orderHasBouquetService.removeOrderHasBouquet(bouquet, principal);
            redirectAttributes.addFlashAttribute("message", "Букет удалён из заказа");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при удалении букета из заказа");
        }

        return "redirect:/order";
    }

    @PostMapping("/order_amountchange/{id}")
    public String changebouquetcount(@PathVariable Long id, @RequestParam(name = "count") Long count, Principal principal, RedirectAttributes redirectAttributes){
        try{
            Bouquet bouquet = bouquetService.getBouquetByID(id);
            orderHasBouquetService.changeAmount(bouquet, principal, count);
        }catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при изменении стоимости");
        }

        return "redirect:/order";
    }


    @PostMapping("/order_checkout")
    public String Checkoutbouquet(@RequestParam(name = "typePostcard") Long typePostcard,
                                  @RequestParam(name = "textPostcard") String textPostcard,
                                  @RequestParam(name = "addressDelivery") String addressDelivery,
                                  @RequestParam(name = "dateDelivery") LocalDate dateDelivery,
                                  @RequestParam(name = "timeDelivery") String timeDelivery,
                                  @RequestParam(name = "dataPostcardId") String dataPostcardId,
                                  @RequestParam(name = "phoneNumber") String phoneNumber,
                                  Principal principal, RedirectAttributes redirectAttributes){
        LocalDateTime datePayment = LocalDateTime.now();
        //даже не спрашивайте , что это. Только так работает
        if(typePostcard == 0){
            char secondChar = dataPostcardId.charAt(0);
            // Преобразование char в String
            String secondCharAsString = String.valueOf(secondChar);
            // Преобразование String в Long
            typePostcard = Long.parseLong(secondCharAsString);
        }
        if(textPostcard == ""){
            textPostcard = null;
        }
        if(textPostcard == ""){
            textPostcard = null;
        }
        try{
            orderService.CheckoutOrder(principal, typePostcard, textPostcard, addressDelivery, datePayment, dateDelivery, timeDelivery, phoneNumber);
            redirectAttributes.addFlashAttribute("message", "Заказ оформлен. Оплата курьеру при получении");
        }catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Ошибка при оформлении заказа");
        }

        return "redirect:/profile";
    }





}
