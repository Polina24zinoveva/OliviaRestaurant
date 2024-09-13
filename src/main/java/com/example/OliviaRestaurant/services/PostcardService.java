package com.example.OliviaRestaurant.services;

import com.example.OliviaRestaurant.models.Image;
import com.example.OliviaRestaurant.models.Postcard;
import com.example.OliviaRestaurant.repositories.ImageRepository;
import com.example.OliviaRestaurant.repositories.PostcardRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
@Slf4j
public class PostcardService {
    @Autowired
    private final PostcardRepository postcardRepository;
    private final ImageRepository imageRepository;


    public PostcardService(PostcardRepository postcardRepository, ImageRepository imageRepository) {
        this.postcardRepository = postcardRepository;
        this.imageRepository = imageRepository;

    }
    public List<Postcard> listAllPostcards(){
        return postcardRepository.findAll();
    }

    public void savePostcard(Postcard postcard, MultipartFile file) throws IOException {
        try {
            if (file.getSize() != 0) {
                Image image = toImageEntity(file);
                imageRepository.save(image);
                postcard.setImage(image);
                postcardRepository.save(postcard);
            }
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
    public void deletePostcard(Long id){
        try {
            Long imageId = postcardRepository.findById(id).get().getImage().getId();
            imageRepository.deleteById(imageId);
            postcardRepository.deleteById(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
