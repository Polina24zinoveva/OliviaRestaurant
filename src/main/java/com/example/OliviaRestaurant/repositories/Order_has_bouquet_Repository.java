package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.modelsOld.Bouquet;
import com.example.OliviaRestaurant.modelsOld.Order;
import com.example.OliviaRestaurant.modelsOld.Order_has_bouquet;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface Order_has_bouquet_Repository extends CrudRepository<Order_has_bouquet, Long> {
    List<Order_has_bouquet> findAllByOrder(Order order);
    Order_has_bouquet findByBouquetAndOrder(Bouquet bouquet, Order order);
    void deleteByBouquetAndOrder(Bouquet bouquet, Order order);
}
