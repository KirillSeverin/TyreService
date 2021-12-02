package ru.tyreservice.aggregator.services.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.Resource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import ru.tyreservice.aggregator.entities.Partner;
import ru.tyreservice.aggregator.exceptions.ImageNotSaveException;
import ru.tyreservice.aggregator.services.ImageService;
import ru.tyreservice.aggregator.services.PartnerService;
import ru.tyreservice.aggregator.utils.GlobalConfig;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@Slf4j
@Service
public class ImageServiceImpl implements ImageService {
    private final PartnerService partnerService;
    private final Path rootDirectory;
    private final Path rootUrl;
    private final DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");
    public ImageServiceImpl(GlobalConfig config, PartnerService partnerService) {
        this.partnerService = partnerService;
        this.rootUrl = Paths.get(config.getRootUrlForImages());
        this.rootDirectory = Paths.get(config.getRootDirectoryForImages());
        try {
            Files.createDirectories(rootDirectory);
        } catch (IOException e) {
            throw new RuntimeException("Не возможно создать директорию для сохранения файлов");
        }
    }

    @Override
    @Transactional
    public void uploadImage(Long partnerId, MultipartFile image) {
        Partner partner = partnerService.findById(partnerId);
        String name = image.getOriginalFilename();
        String ext = name.substring(name.indexOf(".")+1, name.length());
        LocalDateTime ldt = LocalDateTime.now();
        String timeLabel = dateTimeFormatter.format(ldt);
        String imageName = partner.getName().replaceAll("\\s", "") + "_" + timeLabel + "." + ext;
        Path path = rootDirectory.resolve(imageName);
        partner.setImageName(rootUrl.resolve(imageName).toString());
        try {
            Files.copy(image.getInputStream(), path);
            log.info(String.format("User %s uploaded new file. File with name %s saved in the directory %s", partner.getName(),  imageName, rootDirectory));
        } catch (IOException e) {
            e.printStackTrace();
            throw new ImageNotSaveException("Не удалось сохранить изображение. Сообщите об ошибке администратору");
        }
    }
}
