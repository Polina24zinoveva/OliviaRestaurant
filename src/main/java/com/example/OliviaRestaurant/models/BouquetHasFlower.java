package com.example.OliviaRestaurant.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class BouquetHasFlower {
    @Id
    private Long idOrderidBouquet; //id букета
    @Id
    private Long idFlower; //id цветка
    @Column
    private Long count; //Количество цветов
}
