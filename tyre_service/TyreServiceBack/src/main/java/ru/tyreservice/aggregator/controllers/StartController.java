package ru.tyreservice.aggregator.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.tyreservice.aggregator.dto.responses.StartInfoDTO;
import ru.tyreservice.aggregator.services.StartService;
import ru.tyreservice.aggregator.utils.GlobalConfig;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping(value = "api")
@Tag(name = "Запросы, не требующие авторизации")
public class StartController {

    private final StartService startService;
    private final GlobalConfig config;

    @GetMapping
    @Operation(summary = "Стартовая страница", description = "Первичный запрос при запуске приложения. " +
            "Получение списка партнеров, списка всевозможных услуг, типов сервисов и типов учетных записей")
    public StartInfoDTO readStartInfo() {
        log.info("Request: GET http://localhost:" + config.getPort() + "/api");
        return startService.readStartInfo();
    }
}
