package com.example.OliviaRestaurant.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
// Заказ
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "orders")
@Data
public class OrderNew {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idOrder")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "idUser")
    private UserNew user;

    @Column(name = "address")
    private String address;

    @Column(name = "order_time")
    private LocalDateTime orderTime;

    @Column(name = "total_price")
    private Double totalPrice;

    @Column(name = "payment_time")
    private LocalDateTime paymentTime;

    @Column(name = "status")
    private String status;

    @OneToMany(mappedBy = "order")
    private List<OrderDish> orderDishes;
}
