package com.example.OliviaRestaurant.models.enums;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    ROLE_USER, ROLE_COURIER, ROLE_ADMIN, ROLE_MANAGER;

    @Override
    public String getAuthority(){
        return name();
    }
}
