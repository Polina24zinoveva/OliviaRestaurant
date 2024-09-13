package com.example.OliviaRestaurant.models;//package com.example.OliviaFlowers.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Set;

@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "`order`")
@Data
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;  //id заказа

    @ManyToOne
    private User user; //id пользователя

    @Column
    private Long typePostcard; //тип открытки

    @Column
    private String textPostcard; //текст открытки


    @Column
    private String addressDelivery; //Адрес доставки заказа

    @Column
    private LocalDate dateDelivery; //дата доставки

    @Column
    private String timeDelivery; //время доставки

    @Column
    private Long sumOrder; //сумма заказа

    @Column
    private Long sumDelivery; //сумма заказа

    @Column
    private Long sumOrderWithDelivery; //сумма заказа

    @Column
    private LocalDateTime datePayment; //время оплаты заказа

    @OneToMany(mappedBy = "order")
    private Set<Order_has_bouquet> amounts;

    @Column
    private String status; //статус заказа("В корзине", "Оплачен", "Доставлен", "Отменен")

    @Column
    private String phoneNumber; //номер телефона получателя

    // Геттер для datePayment
    public LocalDateTime getDatePayment() {
        return datePayment;
    }

}