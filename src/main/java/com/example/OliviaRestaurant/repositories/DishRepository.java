package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.models.Dish;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface DishRepository extends JpaRepository<Dish, Long> {
    List<Dish> findByName(String name);
    //List<Dish> findByDishType(@Param("dishType") String dishType);
}