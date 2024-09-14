package com.example.OliviaRestaurant.modelsOld;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class Image {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column
    private String name;

    @Column
    private String originalFileName;

    @Column
    private Long size;

    @Column
    private String contentType;

    @Column
    private boolean isPreviewImage;

//    @Column(name = "photo", columnDefinition = "LONGBLOB")
//    @Lob
//    private byte[] bytes;

   @Column(name = "photo", columnDefinition = "BYTEA")
    private byte[] bytes;

    @ManyToOne
    private Bouquet bouquet;
}
