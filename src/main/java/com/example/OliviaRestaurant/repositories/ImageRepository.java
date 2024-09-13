package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.models.Image;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional

public interface ImageRepository extends JpaRepository<Image, Long> {
    void deleteByBouquetId(Long id);
}