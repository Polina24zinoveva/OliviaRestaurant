package com.example.OliviaRestaurant.services;

import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.enums.OrderStatus;
import com.example.OliviaRestaurant.repositories.OrderRepository;
import com.example.OliviaRestaurant.repositories.UserRepository;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
@AllArgsConstructor
public class OrderService {
    @Autowired
    private final OrderRepository orderRepository;
    @Autowired
    private final UserRepository userRepository;


    public boolean saveOrder(Principal principal, Order order){
        order.setUser(getUserByPrincipal(principal));
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


    public Order haveOrderInCardByPrincipal(Principal principal){
        return orderRepository.findByUserAndStatus(getUserByPrincipal(principal), OrderStatus.STATUS_IN_CART);
    }

    public Order haveOrderInCardByUser(User user){
        return orderRepository.findByUserAndStatus(user, OrderStatus.STATUS_IN_CART);
    }

    public Order getOrderByID(Long id){
        return orderRepository.findById(id).orElse(null);
    }


    public List<Order> listAllOrdersToDeliver(){
        return orderRepository.findAllByStatus(OrderStatus.STATUS_PAID);
    }

    public List<Order> listAllOrdersToDeliverByCourier(User courier){
        return orderRepository.findByCourierAndStatus(courier, OrderStatus.STATUS_PAID);
    }

    @Transactional
    public void checkoutOrder(Principal principal,
                              String addressDelivery, LocalDateTime datePayment,
                              LocalDate dateDelivery, String timeDelivery){
        try{
            Order order = haveOrderInCardByPrincipal(principal);
            order.setAddress(addressDelivery);
            order.setDateTimePayment(datePayment);
            order.setDateDelivery(dateDelivery);
            order.setTimeDelivery(timeDelivery);
            order.setStatus(OrderStatus.STATUS_PAID);
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


    public List<Order> listOrders() {
        return orderRepository.findAll();
    }

    public List<Order> listOrdersFinished(){
        return orderRepository.findAllByStatus(OrderStatus.STATUS_DELIVERED);
    }

    public List<Order> ListOrdersFinishedByCourier(User courier){
        return orderRepository.findByCourierAndStatus(courier, OrderStatus.STATUS_DELIVERED);
    }


    public List<Order> ListOrdersActive(User user){
        return orderRepository.findAllByUserAndStatus(user, OrderStatus.STATUS_PAID);
    }

    public List<Order> ListOrdersInactive(Principal principal){
        return orderRepository.findAllByUserAndStatus(getUserByPrincipal(principal),  OrderStatus.STATUS_IN_CART);
    }

    public List<Order> listOrdersFinished(User user){
        return orderRepository.findAllByUserAndStatus(user,  OrderStatus.STATUS_DELIVERED);
    }


    public List<Order> findOrdersByUser(User user) {
        return orderRepository.findByUser(user);
    }


    public int countOrdersByCourierAndDate(User courier, LocalDate date) {
        return orderRepository.findByCourierAndDateDelivery(courier, date).size();
    }

    public List<List<Integer>> getCourierOrdersCountForAllDates(List<Order> orders, List<User> couriers) {
        List<List<Integer>> resultList = new ArrayList<>();
        LocalDate[] dates = orders.stream()
                .map(Order::getDateDelivery)
                .toArray(LocalDate[]::new);

        for(LocalDate date: dates){
            List<Integer> countOrdersForDay = new ArrayList<>();
            for(User courier: couriers){
                countOrdersForDay.add(countOrdersByCourierAndDate(courier, date));
            }
            resultList.add(countOrdersForDay);
        }

        return resultList;
    }

//    public List<Integer> getCourierOrdersCountForAllDates(LocalDate date, List<User> couriers) {
//
//        List<Integer> countOrdersForDay = new ArrayList<>();
//        for(User courier: couriers){
//            countOrdersForDay.add(countOrdersByCourierAndDate(courier, date));
//        }
//
//        return countOrdersForDay;
//    }


}
