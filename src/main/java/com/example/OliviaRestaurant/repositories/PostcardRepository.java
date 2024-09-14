package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.modelsOld.Postcard;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostcardRepository  extends JpaRepository<Postcard, Long> {
}
