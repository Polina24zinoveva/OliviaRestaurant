package com.example.OliviaRestaurant.repositories;


import com.example.OliviaRestaurant.models.Order;
import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.enums.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findAllByUserAndStatus(User user, OrderStatus status);

    List<Order> findByUserAndStatus(User user, OrderStatus status);

    List<Order> findAllByStatus(OrderStatus status);

    List<Order> findByUser(User user);

    List<Order> findByCourierAndStatus(User courier, OrderStatus status);

    List<Order> findByCourierAndDateDelivery(User courier, LocalDate dateDelivery);

    @Query("SELECT o FROM Order o JOIN o.orderHasDishes od WHERE od.dish.id = :dishId AND o.status != :deliveredStatus")
    List<Order> findActiveOrdersByDishId(Long dishId, OrderStatus deliveredStatus);

    @Modifying
    @Query("DELETE FROM OrderHasDish ohd WHERE ohd.dish.id = :dishId AND ohd.order.status = :cartStatus")
    void removeDishFromCarts(@Param("dishId") Long dishId, @Param("cartStatus") OrderStatus cartStatus);

}
