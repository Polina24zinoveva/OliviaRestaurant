package com.example.OliviaRestaurant.repositories;


import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.enums.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findAllByUserAndStatus(User user, OrderStatus status);

    Order findByUserAndStatus(User user, OrderStatus status);
    List<Order> findAllByStatus(OrderStatus status);

    List<Order> findByUser(User user);

    List<Order> findByCourierAndStatus(User courier, OrderStatus status);


    List<Order> findByCourierAndDateDelivery(User courier, LocalDate dateDelivery);
}
