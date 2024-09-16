package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.models.Cuisine;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CuisineRepository extends JpaRepository<Cuisine, Long> {
}
