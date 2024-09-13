package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.models.Postcard;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostcardRepository  extends JpaRepository<Postcard, Long> {
}
