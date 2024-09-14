package com.example.OliviaRestaurant.modelsOld;


import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;

import java.io.Serializable;

@Embeddable
public class Favorite_key implements Serializable {

    @Column(name = "user_id")
    Long idUser;

    @Column(name = "bouquet_id")
    Long idBouquet;

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((idUser == null) ? 0 : idUser.hashCode());
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
        if (idUser == null) {
            if (other.idOrder != null)
                return false;
        } else if (!idUser.equals(other.idOrder))
            return false;
        if (idBouquet == null) {
            if (other.idBouquet != null)
                return false;
        } else if (!idBouquet.equals(other.idBouquet))
            return false;
        return true;
    }


    public void setIdUser(Long userId) { this.idUser = userId;
    }

    public void setIdBouquet(Long bouquetId) { this.idBouquet = bouquetId;
    }


}
