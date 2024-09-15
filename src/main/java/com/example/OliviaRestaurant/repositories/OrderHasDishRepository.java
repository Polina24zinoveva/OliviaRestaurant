package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.models.Dish;
import com.example.OliviaRestaurant.models.OrderHasDish;
import com.example.OliviaRestaurant.models.Order;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface OrderHasDishRepository extends CrudRepository<OrderHasDish, Long> {
    List<OrderHasDish> findAllByOrder(Order order);
    OrderHasDish findByDishAndOrder(Dish dish, Order order);
    void deleteByDishAndOrder(Dish dish, Order order);
}