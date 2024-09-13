package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.models.HomePage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface HomePageRepository extends JpaRepository<HomePage, Long> {
    // Здесь могут быть объявлены дополнительные методы для работы с сущностью HomePage
}
