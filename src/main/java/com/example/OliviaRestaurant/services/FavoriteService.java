package com.example.OliviaRestaurant.services;


import com.example.OliviaRestaurant.modelsOld.*;
import com.example.OliviaRestaurant.repositories.FavoriteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FavoriteService {

    private final FavoriteRepository favoriteRepository;


    @Autowired
    public FavoriteService(FavoriteRepository favoriteRepository) {
        this.favoriteRepository = favoriteRepository;
    }

    public List<Bouquet> getFavoriteBouquetsByUser(User user) {
        List<Favorite> favorites = favoriteRepository.findByUser(user);
        return favorites.stream().map(Favorite::getBouquet).toList();
    }

    public void removeFromFavorites(Long bouquetId, Long userId) {
        Favorite_key favoriteKey = new Favorite_key();
        favoriteKey.setIdUser(userId);
        favoriteKey.setIdBouquet(bouquetId);
        favoriteRepository.deleteById(favoriteKey);
    }

    public boolean saveFavorite(User user, Bouquet bouquet) {
        Favorite_key favoriteKey = new Favorite_key();
        favoriteKey.setIdUser(user.getId());
        favoriteKey.setIdBouquet(bouquet.getId());

        if (favoriteRepository.existsById(favoriteKey)) {
            return false;
        }

        Favorite favorite = new Favorite();
        favorite.setId(favoriteKey);
        favorite.setUser(user);
        favorite.setBouquet(bouquet);
        favoriteRepository.save(favorite);
        return true;
    }

}

