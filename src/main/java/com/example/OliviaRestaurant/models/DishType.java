package com.example.OliviaRestaurant.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
// Справочник: тип блюда
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "dish_types")
@Data
public class DishType {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idDishType")
    private Long id;

    @Column(name = "name", unique = true)
    private String name;

    @OneToMany(mappedBy = "dishType")
    private List<Dish> dishes;
}
