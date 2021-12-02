package ru.tyreservice.aggregator.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import ru.tyreservice.aggregator.dto.requests.ReviewDTO;
import ru.tyreservice.aggregator.dto.responses.PartnerResponseDTO;
import ru.tyreservice.aggregator.dto.responses.PartnerWithDetailsResponseDTO;
import ru.tyreservice.aggregator.dto.responses.StatusResponse;
import ru.tyreservice.aggregator.enums.StateCarType;
import ru.tyreservice.aggregator.services.PartnerService;
import ru.tyreservice.aggregator.services.ReviewService;
import ru.tyreservice.aggregator.utils.GlobalConfig;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping(value = "api")
@Tag(name = "Запросы, не требующие авторизации")
public class PartnerController {
    private final PartnerService partnerService;
    private final ReviewService reviewService;
    private final GlobalConfig config;
    private final String request = "Request: GET http://localhost:%d/api/partners%s";

    @GetMapping(value = "/partners")
    @Operation(summary = "Список партнеров", description = "Получение списка партнеров с возможностью фильтрации по типу сервиса, наименованию сервиса и типу оказываемой услуги")
    public List<PartnerResponseDTO> readListPartnersByFilter(
            @RequestParam(required = false) StateCarType type,
            @RequestParam(required = false) String name,
            @RequestParam(required = false) List<Long> id,
            @RequestParam(required = false) Integer page,
            @RequestParam(required = false) Double latitude,
            @RequestParam(required = false) Double longitude) {
        List<String> params = new ArrayList<>(6);
        if (latitude != null) params.add("latitude="+latitude);
        if (longitude != null) params.add("longitude="+longitude);
        if (type != null) params.add("type="+type);
        if (name != null) params.add("name="+name);
        if (id != null) params.add(id.stream().map(i ->"id="+i).collect(Collectors.joining("&", "", "")));
        if (page != null) params.add("page="+page);
        log.info(String.format(request, config.getPort(), params.stream().collect(Collectors.joining("&", "?", ""))));
        return partnerService.readListPartners(type, name, id , page, latitude, longitude);
    }

    @GetMapping(value = "/partners/{id}")
    @Operation(summary = "Информация о партнере", description = "Подробная информация об одном партнере, в том числе со списком информации об оказываемых услугах с их стоимостью")
    public PartnerWithDetailsResponseDTO readPartnerWithWorks(
            @PathVariable(name = "id") Long id) {
        log.info(String.format(request, config.getPort(), "/" + id));
        return partnerService.readPartnerWithWorks(id);
    }

    @PostMapping(value = "/partners/{id}/reviews")
    @Operation(summary = "Добавление отзыва", description = "При добавлении в переменной пути указывается id партнера, которому добавляется отзыв")
    public StatusResponse createReview(
            @PathVariable(name = "id") Long id, @RequestBody ReviewDTO review) {
        log.info(String.format(request, config.getPort(), "/" + id + "/reviews"));
        reviewService.createReview(id, review);
        return StatusResponse.getOk();
    }
}
