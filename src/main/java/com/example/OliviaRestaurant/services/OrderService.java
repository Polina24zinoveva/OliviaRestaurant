package com.example.OliviaRestaurant.services;

import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.Postcard;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.repositories.OrderRepository;
import com.example.OliviaRestaurant.repositories.PostcardRepository;
import com.example.OliviaRestaurant.repositories.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class OrderService {
    @Autowired
    private final OrderRepository orderRepository;
    @Autowired
    private final UserRepository userRepository;
    @Autowired
    private PostcardRepository postcardRepository;


    public OrderService(OrderRepository orderRepository, UserRepository userRepository){
        this.orderRepository = orderRepository;
        this.userRepository = userRepository;
    }

    public boolean saveOrder(Principal principal, Order order){
        order.setUser(getUserByPrincipal(principal));;
        orderRepository.save(order);
        return true;
    }

    public boolean saveOrder(Order order){
        orderRepository.save(order);
        return true;
    }

    public User getUserByPrincipal(Principal principal){
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public Order HaveOrderInCardByPrincipal(Principal principal){
        return orderRepository.findByUserAndStatus(getUserByPrincipal(principal), "В корзине");
    }

    public Order HaveOrderInCardByUser(User user){
        return orderRepository.findByUserAndStatus(user, "В корзине");
    }

    public Order getOrderByID(Long id){
        return orderRepository.findById(id).orElse(null);
    }


    public List<Order> ListAllOrdersToDeliver(){
        return orderRepository.findAllByStatus("Оплачен");
    }

    public List<Postcard> getPostCardToDelivery(List<Order> orders){
        List<Postcard> postcards = new ArrayList<>();
        orders.forEach(order -> {
            postcards.add(postcardRepository.findById(order.getTypePostcard()).orElse(null));
        });

        return postcards;
    }

    @Transactional
    public void CheckoutOrder(Principal principal, Long typePostcard, String textPostcard,
                              String addressDelivery, LocalDateTime datePayment,
                              LocalDate dateDelivery, String timeDelivery, String phoneNumber){
        try{
            Order order = HaveOrderInCardByPrincipal(principal);
            order.setTypePostcard(typePostcard);
            order.setTextPostcard(textPostcard);
            order.setAddressDelivery(addressDelivery);
            order.setDatePayment(datePayment);
            order.setDateDelivery(dateDelivery);
            order.setTimeDelivery(timeDelivery);
            order.setStatus("Оплачен");
            order.setPhoneNumber(phoneNumber);
            orderRepository.save(order);
        }catch (Exception e){
            e.printStackTrace();
        }


    }

    /*@Transactional
    public void DeliverOrder(Order order, LocalDateTime deliverydate){
        try{order.setActive((long)3);
            order.setDateTimeDelivery(deliverydate);//3 активность - доставлен
        }catch(Exception e){
            e.printStackTrace();
        }
    }*/

    @Transactional
    public void CancelOrder(Order order){
        try{
            order.setStatus("Отменен"); //активность - отменён
        }catch(Exception e){
            e.printStackTrace();
        }
    }





    public List<Order> ListOrders() {
        return orderRepository.findAll();
    }
    public List<Order> ListOrdersFinished(){
        return orderRepository.findAllByStatus("Доставлен");
    }

    public List<Order> ListOrdersCanceled(){
        return orderRepository.findAllByStatus("Отменен");
    }

    public List<Order> ListOrdersActive(User user){
        return orderRepository.findAllByUserAndStatus(user, "Оплачен");
    }

    public List<Order> ListOrdersInactive(Principal principal){
        return orderRepository.findAllByUserAndStatus(getUserByPrincipal(principal),  "В корзине");
    }

    public List<Order> ListOrdersFinished(User user){
        return orderRepository.findAllByUserAndStatus(user,  "Доставлен");
    }


    public List<Order> findOrdersByUser(User user) {
        return orderRepository.findByUser(user);
    }



}
