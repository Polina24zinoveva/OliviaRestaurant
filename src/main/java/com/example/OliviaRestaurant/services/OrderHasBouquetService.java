package com.example.OliviaRestaurant.services;

import com.example.OliviaRestaurant.modelsOld.*;
import com.example.OliviaRestaurant.repositories.BouquetRepository;
import com.example.OliviaRestaurant.repositories.OrderRepository;
import com.example.OliviaRestaurant.repositories.Order_has_bouquet_Repository;
import com.example.OliviaRestaurant.repositories.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class OrderHasBouquetService {
    @Autowired
    private final Order_has_bouquet_Repository order_has_bouquet_Repository;
    @Autowired
    private final OrderRepository orderRepository;
    @Autowired
    private final BouquetRepository bouquetRepository;
    @Autowired
    private final UserRepository userRepository;

    public OrderHasBouquetService(Order_has_bouquet_Repository order_has_bouquet_Repository, OrderRepository orderRepository, BouquetRepository bouquetRepository, UserRepository userRepository ) {
        this.order_has_bouquet_Repository = order_has_bouquet_Repository;
        this.orderRepository = orderRepository;
        this.bouquetRepository = bouquetRepository;
        this.userRepository = userRepository;
    }

    public boolean saveOrderHasBouquet(Order_has_bouquet order_has_bouquet) {
        order_has_bouquet_Repository.save(order_has_bouquet);
        return true;
    }

    public List<Bouquet> getbouquetsByOrder(Order order){
        List<Order_has_bouquet> OhBs = order_has_bouquet_Repository.findAllByOrder(order);
        List<Bouquet> bouqlist = new ArrayList<Bouquet>();
        OhBs.forEach(ohb -> {
            bouqlist.add(ohb.getBouquet());
        });
        return  bouqlist;
    }

    public List<Long> getAmountsByOrder(Order order){
        List<Order_has_bouquet> OhBs = order_has_bouquet_Repository.findAllByOrder(order);
        List<Long> amlist= new ArrayList<Long>();
        OhBs.forEach(ohb -> {
            amlist.add(ohb.getCount());
        });
        return amlist;
    }

    public List<Bouquet> getBouquetsByListOrder(List<Order> orderlist){
        List<Order_has_bouquet> OhBs = new ArrayList<Order_has_bouquet>();
        orderlist.forEach(order -> {
            OhBs.addAll(order_has_bouquet_Repository.findAllByOrder(order));
        });
        List<Bouquet> bouqlist = new ArrayList<Bouquet>();
        OhBs.forEach(ohb -> {
            bouqlist.add(ohb.getBouquet());
        });
        return bouqlist;
    }

    public List<List<Bouquet>> getPendingBouquets(List<Order> orderList){
        List<List<Bouquet>> listoflists = new ArrayList<>();
        orderList.forEach(order -> {
            listoflists.add(getbouquetsByOrder(order));
        });
        return listoflists;
    }

    public List<List<Long>> getPendingamount(List<Order> orderList){
        List<List<Long>> listoflists = new ArrayList<>();
        orderList.forEach(order -> {
            listoflists.add(getAmountsByOrder(order));
        });
        return listoflists;
    }










    public boolean saveOrderHasBouquet(Order order, Bouquet bouquet) {
        Long idOrder = order.getId();
        Long idBouquet = bouquet.getId();
        Order_has_bouquet_key id = new Order_has_bouquet_key(idOrder, idBouquet);
        Order_has_bouquet ohb = new Order_has_bouquet();
        ohb.setId(id);
        if (bouquet != null && order != null) {
            ohb.setBouquet(bouquet);
            ohb.setOrder(order);
            ohb.setCount((long)1);
            order_has_bouquet_Repository.save(ohb);
            return true;
        }
        return false;



    }

    public User getUserByPrincipal(Principal principal){
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public boolean createOrderHasBouquet(Bouquet bouquet, Principal principal) {
        if (principal == null || bouquet == null) return false;
        if(orderRepository.findByUserAndStatus(getUserByPrincipal(principal), "В корзине") == null){
            Order order = new Order();
            order.setUser(getUserByPrincipal(principal));
            order.setStatus("В корзине");
            order.setSumOrder((long)0);
            order.setSumDelivery((long)0);
            order.setSumOrderWithDelivery((long)0);

            orderRepository.save(order);
        }
        Order ordere = orderRepository.findByUserAndStatus(getUserByPrincipal(principal), "В корзине");
        ordere.setSumOrder(ordere.getSumOrder() + bouquet.getPrice());
        if (ordere.getSumOrder() < 3000L){
            ordere.setSumDelivery((long)300);
        }
        else if(ordere.getSumOrder() >= 3000L){
            ordere.setSumDelivery((long)0);
        }
        ordere.setSumOrderWithDelivery(ordere.getSumOrder() + ordere.getSumDelivery());
        return saveOrderHasBouquet(ordere, bouquet);

    }

    @Transactional
    public void removeOrderHasBouquet(Bouquet bouquet, Principal principal){

        try{
            Order ordere = orderRepository.findByUserAndStatus(getUserByPrincipal(principal), "В корзине");
            Order_has_bouquet ohb = order_has_bouquet_Repository.findByBouquetAndOrder(bouquet, ordere);
            Long delta = ohb.getCount()*bouquet.getPrice();
            order_has_bouquet_Repository.deleteByBouquetAndOrder(bouquet, ordere);
            ordere.setSumOrder(ordere.getSumOrder()-delta);
            orderRepository.save(ordere);


            if (getbouquetsByOrder(ordere).isEmpty()){
                orderRepository.deleteById(ordere.getId());
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }


    }

    public void changeAmount(Bouquet bouquet, Principal principal, Long amount){
        try{
            Order ordere = orderRepository.findByUserAndStatus(getUserByPrincipal(principal), "В корзине");
            Long oldamount = order_has_bouquet_Repository.findByBouquetAndOrder(bouquet, ordere).getCount();
            Long deltasum = amount*bouquet.getPrice() - oldamount*bouquet.getPrice();
            Order_has_bouquet ohb = order_has_bouquet_Repository.findByBouquetAndOrder(bouquet, ordere);
            ohb.setCount(amount);

            ordere.setSumOrder(ordere.getSumOrder() + deltasum);

            if (ordere.getSumOrder() < 3000L){
                ordere.setSumDelivery((long)300);
            }
            else if(ordere.getSumOrder() >= 3000L){
                ordere.setSumDelivery((long)0);
            }
            ordere.setSumOrderWithDelivery(ordere.getSumOrder() + ordere.getSumDelivery());

            order_has_bouquet_Repository.save(ohb);
            orderRepository.save(ordere);

        }
        catch(Exception e){
            e.printStackTrace();
        }
    }

    public boolean removeOhBById(Long id, Principal principal){
        Bouquet bouquet = bouquetRepository.findById(id).get();
        removeOrderHasBouquet(bouquet, principal);
        return true;
    }




}
