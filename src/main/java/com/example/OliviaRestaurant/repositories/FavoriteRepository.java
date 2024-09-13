package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.models.Favorite;
import com.example.OliviaRestaurant.models.Favorite_key;
import com.example.OliviaRestaurant.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FavoriteRepository extends JpaRepository<Favorite, Favorite_key> {
    List<Favorite> findByUser(User user);
    void deleteById(Favorite_key favoriteKey);
}
