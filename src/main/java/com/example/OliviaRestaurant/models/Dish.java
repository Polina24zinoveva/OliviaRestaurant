package com.example.OliviaRestaurant.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

//Блюда
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
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

    @Column(name = "composition", columnDefinition = "text")
    private String composition;

    @ManyToOne
    @JoinColumn(name = "cuisine_id")
    private Cuisine cuisine;

    @ManyToOne
    @JoinColumn(name = "dish_type_id")
    private DishType dishType;

    @Column(name = "in_menu")
    private Boolean inMenu = false;

    @OneToMany(mappedBy = "dish")
    private List<OrderHasDish> orderHasDishes = new ArrayList<>();

    @OneToMany(mappedBy = "dish")
    private List<Image> images = new ArrayList<>();

}
