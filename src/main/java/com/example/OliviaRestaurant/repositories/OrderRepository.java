package com.example.OliviaRestaurant.repositories;


import com.example.OliviaRestaurant.modelsOld.Order;
import com.example.OliviaRestaurant.modelsOld.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findAllByUserAndStatus(User user, String status);

    Order findByUserAndStatus(User user, String status);
    List<Order> findAllByStatus(String status);

    List<Order> findByUser(User user);
}
