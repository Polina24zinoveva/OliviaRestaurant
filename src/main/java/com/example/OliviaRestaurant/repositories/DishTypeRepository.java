package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.models.DishType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DishTypeRepository extends JpaRepository<DishType, Long> {
}
