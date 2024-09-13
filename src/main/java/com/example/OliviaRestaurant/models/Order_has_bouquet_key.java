package com.example.OliviaRestaurant.models;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;



@Embeddable
public class Order_has_bouquet_key implements Serializable {

    @Column(name = "order_id")
    Long idOrder;

    @Column(name = "bouquet_id")
    Long idBouquet;

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((idOrder == null) ? 0 : idOrder.hashCode());
        result = prime * result + ((idBouquet == null) ? 0 : idBouquet.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Order_has_bouquet_key other = (Order_has_bouquet_key) obj;
        if (idOrder == null) {
            if (other.idOrder != null)
                return false;
        } else if (!idOrder.equals(other.idOrder))
            return false;
        if (idBouquet == null) {
            if (other.idBouquet != null)
                return false;
        } else if (!idBouquet.equals(other.idBouquet))
            return false;
        return true;
    }

    public Order_has_bouquet_key(Long idOrder, Long idBouquet) {
        this.idOrder = idOrder;
        this.idBouquet = idBouquet;
    }

    public Order_has_bouquet_key(){

    }

    public Long getIdOrder() {
        return idOrder;
    }

    public Long getIdBouquet() {
        return idBouquet;
    }
}
