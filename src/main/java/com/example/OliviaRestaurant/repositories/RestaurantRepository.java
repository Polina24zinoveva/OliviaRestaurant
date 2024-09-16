package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.models.Restaurant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RestaurantRepository extends JpaRepository<Restaurant, Long> {
}
