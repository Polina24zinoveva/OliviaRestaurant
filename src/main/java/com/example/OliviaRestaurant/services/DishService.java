package com.example.OliviaRestaurant.services;

import com.example.OliviaRestaurant.models.Dish;
import com.example.OliviaRestaurant.models.Image;
import com.example.OliviaRestaurant.repositories.DishRepository;
import com.example.OliviaRestaurant.repositories.ImageRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
@AllArgsConstructor
public class DishService {

    @PersistenceContext
    private EntityManager entityManager;
    @Autowired
    private final DishRepository dishRepository;
    private final ImageRepository imageRepository;


    public List<Dish> listAllDishesByName(String name){
        if (name != null) return dishRepository.findByName(name);
        return dishRepository.findAll();
    }
    public List<Dish> listAllDishes(){
        return dishRepository.findAll();
    }


    //если что-то не работает в методе можно try, catch использовать и ошибки будут выводиться в консоль
    public void saveDish(Dish dish, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        try {
            // Сохраняем букет и получаем его ID
            Dish savedDish = dishRepository.save(dish);

            // Создаем список для хранения всех изображений
            List<Image> images = new ArrayList<>();

            if (file1.getSize() != 0) {
                Image image1 = toImageEntity(file1);
                // Устанавливаем ссылку на сохраненный букет
                image1.setDish(savedDish);
                images.add(image1); // Добавляем изображение в список
            }
            if (file2.getSize() != 0) {
                Image image2 = toImageEntity(file2);
                // Устанавливаем ссылку на сохраненный букет
                image2.setDish(savedDish);
                images.add(image2); // Добавляем изображение в список
            }
            if (file3.getSize() != 0) {
                Image image3 = toImageEntity(file3);
                // Устанавливаем ссылку на сохраненный букет
                image3.setDish(savedDish);
                images.add(image3); // Добавляем изображение в список
            }

            // Сохраняем все изображения
            imageRepository.saveAll(images);

            // Устанавливаем изображения букету
            savedDish.setImages(images);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }





    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }


    @Transactional
    public void deleteDish(Long id){
        try {
            deleteImagesByDishId(id); // Удалить все изображения, связанные с букетом
            dishRepository.deleteById(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Transactional
    public void deleteImagesByDishId(Long bouquetId) {
        try {
            imageRepository.deleteByDishId(bouquetId);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Dish getDishByID(Long id){
        return dishRepository.findById(id).orElse(null);
    }

    public List<Dish> listDishesInMenu(){
        return dishRepository.findAll().stream().filter(dish -> dish.getInMenu() == true).collect(Collectors.toList()) ;
    }
//
//    public List<Bouquet> listAuthorBouquets() {
//        return dishRepository.findByType("Авторский");
//    }
//
//    public List<Bouquet> listBoxBouquets(){
//        return dishRepository.findByType("В коробке");
//    }
//
//    public List<Bouquet> listWeddingBouquets(){
//        return dishRepository.findByType("Cвадебный");
//    }


    public List<Dish> filterDishes(Integer sort, Long minPrice, Long maxPrice, List<String> searchableu, List<Dish> a) {
        List<Dish> dishes = a;

        // Фильтрация по ценовому диапазону
        if (!searchableu.isEmpty()) {
            String[] searchables = searchableu.toArray(new String[0]);
            dishes = dishes.stream()
                    .filter(b -> b.getPrice() >= minPrice && b.getPrice() <= maxPrice)
                    .collect(Collectors.toList());
        } else {
            dishes = dishes.stream()
                    .filter(b -> b.getPrice() >= minPrice && b.getPrice() <= maxPrice)
                    .collect(Collectors.toList());
        }

        // Сортировка по цене, если задано
        if (sort != null) {
            if (sort == 1) {
                dishes.sort(Comparator.comparingDouble(Dish::getPrice));
            } else if (sort == 2) {
                dishes.sort(Comparator.comparingDouble(Dish::getPrice).reversed());
            }
        }

        return dishes;
    }

}
