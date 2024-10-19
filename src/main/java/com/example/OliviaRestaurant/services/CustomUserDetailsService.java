package com.example.OliviaRestaurant.services;


import com.example.OliviaRestaurant.repositories.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    private final HttpSession httpSession;
    public CustomUserDetailsService(HttpSession httpSession, UserRepository userRepository) {
        this.httpSession = httpSession;
        this.userRepository = userRepository;
    }
    @Autowired
    private final UserRepository userRepository;
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        httpSession.setAttribute("userEmail", email);
        return userRepository.findByEmail(email);
    }
}
