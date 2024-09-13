package com.example.OliviaRestaurant.models;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Favorite {
    @EmbeddedId
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Favorite_key id;

    @ManyToOne
    @MapsId("idUser")
    @JoinColumn(name = "user_id")
    User user; //заказ

    @ManyToOne
    @MapsId("idBouquet")
    @JoinColumn(name = "bouquet_id")
    Bouquet bouquet; //id букета

    @Column
    private boolean isFavorite; //Любимый букет или нет

    public Favorite_key getId() {
        return id;
    }

    public void setUser(User user) {
        this.user = user;
    }


    public void setBouquet(Bouquet bouquet) {
        this.bouquet = bouquet;
    }

    public void setId(Favorite_key id) {
        this.id = id;
    }
}
