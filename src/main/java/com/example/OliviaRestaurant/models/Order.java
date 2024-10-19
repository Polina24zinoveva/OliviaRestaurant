package com.example.OliviaRestaurant.models;

import com.example.OliviaRestaurant.models.enums.OrderStatus;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
// Заказ
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "orders")
@Data
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idOrder")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_user", referencedColumnName = "idUser")
    private User user;

    @Column(name = "address")
    private String address;

    @Column(name = "order_time")
    private LocalDateTime orderTime;

    @Column(name = "total_price")
    private Double totalPrice;

    @Column(name = "date_time_payment")
    private LocalDateTime dateTimePayment;

    @Enumerated(EnumType.STRING)
    private OrderStatus status;

    @Column(name = "date_delivery")
    private LocalDate dateDelivery;

    @Column(name = "time_delivery")
    private String timeDelivery;

    @ManyToOne
    @JoinColumn(name = "id_courier", referencedColumnName = "idUser")
    private User courier;

    @Column(name = "courier_time_delivery")
    private LocalDateTime courierDateTimeDelivery;


    @OneToMany(mappedBy = "order")
    private List<OrderHasDish> orderHasDishes;

    @Override
    public String toString() {
        return "Order{dateDelivery=" + dateDelivery + ", user=" + user + "}";
    }

    public String getFormattedDateDelivery() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
        return dateDelivery.format(formatter);
    }

    public String getFormattedDateTimePayment() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");
        return dateTimePayment.format(formatter);
    }

    public String getFormattedCourierDateTimeDelivery() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");
        return courierDateTimeDelivery.format(formatter);
    }
}
