package com.example.OliviaRestaurant.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;
//Блюда
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "dishes")
@Data
public class Dish {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idDish")
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "price")
    private Double price;

    @Column(name = "calories")
    private Integer calories;

    @Column(name = "weight")
    private Integer weight;

    @ManyToOne
    @JoinColumn(name = "cuisine_id")
    private Cuisine cuisine;

    @ManyToOne
    @JoinColumn(name = "dish_type_id")
    private DishType dishType;

    @OneToMany(mappedBy = "dish")
    private List<OrderDish> orderDishes = new ArrayList<>();
}
