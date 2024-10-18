package com.example.OliviaRestaurant.services;

import com.example.OliviaRestaurant.models.User;
import com.example.OliviaRestaurant.repositories.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

import static com.example.OliviaRestaurant.models.enums.Role.*;

@Service
@Slf4j
public class UserService {
    @Autowired
    private final UserRepository userRepository;
    @Autowired
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public boolean createUser(User user){
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) {
            return false;
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(ROLE_USER);

        userRepository.save(user);

        return true;
    }

    public User getUserById(Long userId) {
        return userRepository.findById(userId).orElse(null);
    }

    public User getUserByEmail(String userEmail) {
        return userRepository.findByEmail(userEmail);
    }

    public void save(User user) {
        userRepository.save(user);  // Сохраняем изменения в базе данных
    }

    public List<User> listAllUsersExceptAdmin(){
        return userRepository.findAll().stream().filter(user -> user.getRole() != ROLE_ADMIN).collect(Collectors.toList());
    }

    public List<User> listAllEmployee(){
        return userRepository.findAll().stream().filter(user -> user.getRole() != ROLE_USER &&  user.getRole() != ROLE_ADMIN).collect(Collectors.toList());
    }

    public List<User> listAllClient(){
        return userRepository.findAll().stream().filter(user -> user.getRole() == ROLE_USER).collect(Collectors.toList());
    }

    public List<User> listAllManagers(){
        return userRepository.findAll().stream().filter(user -> user.getRole() == ROLE_MANAGER).collect(Collectors.toList());
    }

    public List<User> listAllCouriers(){
        return userRepository.findAll().stream().filter(user -> user.getRole() == ROLE_COURIER).collect(Collectors.toList());
    }
}