package com.example.OliviaRestaurant.repositories;


import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.enums.Role;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    User findByPhoneNumber(String phoneNumber);
    List<User> findByName(String name);
    List<User> findBySurname(String surname);
}

