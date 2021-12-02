package ru.tyreservice.aggregator.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import ru.tyreservice.aggregator.dto.requests.WorkRequestDTO;
import ru.tyreservice.aggregator.dto.responses.StatusResponse;
import ru.tyreservice.aggregator.dto.responses.WorkResponseDTO;
import ru.tyreservice.aggregator.services.WorkService;
import ru.tyreservice.aggregator.utils.GlobalConfig;

import java.util.List;

import static ru.tyreservice.aggregator.security.SecurityUtil.getAccount;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping(value = "api/works")
@Tag(name = "Запросы, требующие авторизацию")
@SecurityScheme(type = SecuritySchemeType.HTTP)
public class WorkController {
    private final WorkService workService;
    private final GlobalConfig config;
    private final String request = "Request: %s http://localhost:%d/api/works";


    @PostMapping()
    @Operation(summary = "Создание услуги", description = "Создание услуги с подробным описанием",
            security = @SecurityRequirement(name = "basic"))
    public StatusResponse createWork(
            @RequestBody WorkRequestDTO work) {
        log.info(String.format(request, "POST", config.getPort()));
        workService.createWork(work);
        log.info(String.format("User %s create work", getAccount().getUsername()));
        return StatusResponse.getOk();
    }

    @GetMapping()
    @Operation(summary = "Получение списка услуг", description = "Получение списка услуг из общего справочника",
            security = @SecurityRequirement(name = "basic"))
    public List<WorkResponseDTO> readListWorks() {
        log.info(String.format(request, "GET", config.getPort()));
        log.info(String.format("User %s read list of works", getAccount().getUsername()));
        return workService.readListWorks();
    }
}
