package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.modelsOld.Bouquet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BouquetRepository extends JpaRepository<Bouquet, Long> {
    List<Bouquet> findByName(String name);
    List<Bouquet> findByType(@Param("type") String type);
}
