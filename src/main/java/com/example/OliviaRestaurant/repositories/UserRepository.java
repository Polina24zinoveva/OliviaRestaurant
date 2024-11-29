package com.example.OliviaRestaurant.repositories;


import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.models.enums.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    User findByPhoneNumber(String phoneNumber);
    List<User> findByName(String name);
    List<User> findBySurname(String surname);


    List<User> findByNameContainingIgnoreCase(String name);
    List<User> findBySurnameContainingIgnoreCase(String surname);
    List<User> findByPhoneNumberContaining(String phoneNumber);
    List<User> findByEmailContaining(String email);

    // Или можно использовать аннотацию @Query для более сложных запросов
    @Query("SELECT u FROM User u WHERE u.name LIKE %:searchQuery%")
    List<User> findByNameLike(@Param("searchQuery") String searchQuery);

    @Query("SELECT u FROM User u WHERE u.surname LIKE %:searchQuery%")
    List<User> findBySurnameLike(@Param("searchQuery") String searchQuery);
}

