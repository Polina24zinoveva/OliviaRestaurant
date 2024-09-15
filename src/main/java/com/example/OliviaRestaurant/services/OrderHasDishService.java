package com.example.OliviaRestaurant.services;

import com.example.OliviaRestaurant.models.Dish;
import com.example.OliviaRestaurant.models.OrderHasDish;
import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.repositories.*;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;


@Service
@Slf4j
@AllArgsConstructor
public class OrderHasDishService {
    @Autowired
    private final OrderHasDishRepository orderHasDishRepository;
    @Autowired
    private final OrderRepository orderRepository;
    @Autowired
    private final DishRepository dishRepository;
    @Autowired
    private final UserRepository userRepository;



    public boolean saveOrderHasDish(OrderHasDish orderHasDish) {
        orderHasDishRepository.save(orderHasDish);
        return true;
    }

    public List<Dish> getDishesByOrder(Order order){
        List<OrderHasDish> OhBs = orderHasDishRepository.findAllByOrder(order);
        List<Dish> disheslist = new ArrayList<>();
        OhBs.forEach(ohb -> {
            disheslist.add(ohb.getDish());
        });
        return disheslist;
    }

    public List<Integer> getAmountsByOrder(Order order){
        List<OrderHasDish> orderHasDishes = orderHasDishRepository.findAllByOrder(order);
        List<Integer> amlist= new ArrayList<>();
        orderHasDishes.forEach(ohb -> {
            amlist.add(ohb.getCount());
        });
        return amlist;
    }

    public List<Dish> getDishesByListOrder(List<Order> orderlist){
        List<OrderHasDish> orderHasDishes = new ArrayList<>();
        orderlist.forEach(order -> {
            orderHasDishes.addAll(orderHasDishRepository.findAllByOrder(order));
        });
        List<Dish> dishList = new ArrayList<>();
        orderHasDishes.forEach(ohb -> {
            dishList.add(ohb.getDish());
        });
        return dishList;
    }

    public List<List<Dish>> getPendingDishes(List<Order> orderList){
        List<List<Dish>> listOfLists = new ArrayList<>();
        orderList.forEach(order -> {
            listOfLists.add(getDishesByOrder(order));
        });
        return listOfLists;
    }

    public List<List<Integer>> getPendingAmount(List<Order> orderList){
        List<List<Integer>> listOfLists = new ArrayList<>();
        orderList.forEach(order -> {
            listOfLists.add(getAmountsByOrder(order));
        });
        return listOfLists;
    }


    public boolean saveOrderHasDish(Order order, Dish dish) {
        Long idOrder = order.getId();
        Long idBouquet = dish.getId();
        OrderHasDish orderHasDish = new OrderHasDish();
        if (dish != null && order != null) {
            orderHasDish.setDish(dish);
            orderHasDish.setOrder(order);
            orderHasDish.setCount(1);
            orderHasDishRepository.save(orderHasDish);
            return true;
        }
        return false;
    }

    public User getUserByPrincipal(Principal principal){
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public boolean createOrderHasDish(Dish dish, Principal principal) {
        if (principal == null || dish == null) return false;
        if(orderRepository.findByUserAndStatus(getUserByPrincipal(principal), "В корзине") == null){
            Order order = new Order();
            order.setUser(getUserByPrincipal(principal));
            order.setStatus("В корзине");
            order.setTotalPrice(0.0);
            orderRepository.save(order);
        }
        Order order = orderRepository.findByUserAndStatus(getUserByPrincipal(principal), "В корзине");
        return saveOrderHasDish(order, dish);

    }

    @Transactional
    public void removeOrderHasDish(Dish dish, Principal principal){
        try{
            Order order = orderRepository.findByUserAndStatus(getUserByPrincipal(principal), "В корзине");
            OrderHasDish orderHasDish = orderHasDishRepository.findByDishAndOrder(dish, order);
            Double delta = orderHasDish.getCount()*dish.getPrice();
            orderHasDishRepository.deleteByDishAndOrder(dish, order);
            order.setTotalPrice(order.getTotalPrice()-delta);
            orderRepository.save(order);

            if (getDishesByOrder(order).isEmpty()){
                orderRepository.deleteById(order.getId());
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }

    public void changeAmount(Dish dish, Principal principal, Integer amount){
        try{
            Order order = orderRepository.findByUserAndStatus(getUserByPrincipal(principal), "В корзине");
            Integer oldAmount = orderHasDishRepository.findByDishAndOrder(dish, order).getCount();
            Double deltaSum = amount*dish.getPrice() - oldAmount*dish.getPrice();
            OrderHasDish orderHasDish = orderHasDishRepository.findByDishAndOrder(dish, order);
            orderHasDish.setCount(amount);

            order.setTotalPrice(order.getTotalPrice() + deltaSum);
            orderHasDishRepository.save(orderHasDish);
            orderRepository.save(order);
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }

    public boolean removeOrderHasDishById(Long id, Principal principal){
        Dish dish = dishRepository.findById(id).get();
        removeOrderHasDish(dish, principal);
        return true;
    }
}