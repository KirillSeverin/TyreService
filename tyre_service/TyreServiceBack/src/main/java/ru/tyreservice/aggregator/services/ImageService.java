package ru.tyreservice.aggregator.services;

import org.springframework.web.multipart.MultipartFile;

public interface ImageService {
    void uploadImage(Long partnerId, MultipartFile image);
}
