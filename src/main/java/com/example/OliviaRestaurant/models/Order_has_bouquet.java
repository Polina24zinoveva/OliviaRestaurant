package com.example.OliviaRestaurant.models;//package com.example.OliviaFlowers.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Order_has_bouquet {

    @EmbeddedId
    Order_has_bouquet_key id;

    @ManyToOne
    @MapsId("idOrder")
    @JoinColumn(name = "order_id")
    Order order; //заказ

    @ManyToOne
    @MapsId("idBouquet")
    @JoinColumn(name = "bouquet_id")
    Bouquet bouquet; //id букета

    @Column
    private Long count; //Количество букетов

    public Order_has_bouquet_key GetId(){
        return id;
    }

    public Long GetOrderId(){
        return id.idOrder;
    }

    public Long GetBouquetId(){
        return id.idBouquet;
    }



}