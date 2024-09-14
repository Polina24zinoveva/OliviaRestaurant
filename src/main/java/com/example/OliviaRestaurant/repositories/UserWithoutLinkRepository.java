package com.example.OliviaRestaurant.repositories;

import com.example.OliviaRestaurant.modelsOld.UserWithoutLink;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserWithoutLinkRepository extends JpaRepository<UserWithoutLink, Long> {
    UserWithoutLink findByEmail(String email);

    UserWithoutLink findByActivationCode(String code);
}
