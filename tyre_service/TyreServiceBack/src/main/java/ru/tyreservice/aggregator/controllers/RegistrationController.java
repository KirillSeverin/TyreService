package ru.tyreservice.aggregator.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.tyreservice.aggregator.dto.requests.RegDataRequest;
import ru.tyreservice.aggregator.dto.responses.StatusResponse;
import ru.tyreservice.aggregator.services.RegistrationService;
import ru.tyreservice.aggregator.utils.GlobalConfig;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping(value = "api")
@Tag(name = "Запросы, не требующие авторизации")
public class RegistrationController {
    private final RegistrationService registerService;
    private final GlobalConfig config;

    @Operation(summary = "Регистрация нового партнера или клиента",
            description = "4 поля обязательные к заполнению при регистрации: логин, пароль, наименование организации или имя клиента, телефон " +
                    "Если будут не заполнено хотя бы одно поле, регистрация будет отклонена с указанием причины). " +
                    "Тип личного кабинета(PARTNER/CLIENT, пока ничего не присылаем, по умолчанию партнер). ")
    @PostMapping(value = "/registration")
    public StatusResponse register(@RequestBody RegDataRequest regData) {
        log.info("Request: POST http://localhost:" + config.getPort() + "/api/registration");
        log.info("Registration new account");
        registerService.register(regData);
        return StatusResponse.getOk();
    }
}
