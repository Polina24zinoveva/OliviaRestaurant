package com.example.OliviaRestaurant.modelsOld;//package com.example.OliviaFlowers.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "bouquet")
public class Bouquet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; //id букета

    @Column(name = "name")
    private String name; //название

    @Column(name = "composition", columnDefinition = "text")
    private String composition;

    @Column(name = "price")
    private Long price; //цена

    @Column(name = "type")
    private String type;

    @OneToMany
    private List<Image> images = new ArrayList<>();


    private Long previewImageID;

    @OneToMany(mappedBy = "bouquet")
    private Set<Favorite> favorites;


    @OneToMany(mappedBy = "bouquet")
    private Set<Order_has_bouquet> amounts;

    @Transient
    public String[] flowers; //@transient по идее не свяжет с БД

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Long getPrice() {
        return price;
    }
}
