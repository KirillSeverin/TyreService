package ru.tyreservice.aggregator.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.security.SecurityScheme;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import ru.tyreservice.aggregator.dto.requests.ClientDTO;
import ru.tyreservice.aggregator.dto.requests.CostWorkRequestDTO;
import ru.tyreservice.aggregator.dto.requests.PartnerRequestDTO;
import ru.tyreservice.aggregator.dto.responses.*;
import ru.tyreservice.aggregator.enums.EnumUtil;
import ru.tyreservice.aggregator.enums.Role;
import ru.tyreservice.aggregator.enums.StateCarType;
import ru.tyreservice.aggregator.enums.StateStatus;
import ru.tyreservice.aggregator.security.UserAccount;
import ru.tyreservice.aggregator.services.*;
import ru.tyreservice.aggregator.utils.GlobalConfig;

import javax.servlet.http.HttpSession;
import java.util.List;

import static ru.tyreservice.aggregator.security.SecurityUtil.getAccount;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping(value = "api")
@Tag(name = "Запросы, требующие авторизацию")
@SecurityScheme(type = SecuritySchemeType.HTTP)
public class PrivateRoomController {
    private final PartnerService partnerService;
    private final ClientService clientService;
    private final CostWorkService costWorkService;
    private final OrderService orderService;
    private final ImageService imageService;
    private final ObjectMapper mapper;
    private final GlobalConfig config;
    private final String request = "Request: %s http://localhost:%d/api/lk%s";

    @Operation(summary = "Вход в личный кабинет",
            description = "Первичный запрос на вход в кабинет, в ответ приходи идетнификатор сессии",
            security = @SecurityRequirement(name = "basic"))
    @GetMapping(value = "/login")
    public String login(HttpSession session) {
        session.setMaxInactiveInterval(-1);
        return session.getId();
    }

    @Operation(summary = "Главная страница личного кабинета",
            description = "Основная информация в личном кабинете",
            security = @SecurityRequirement(name = "basic"))
    @GetMapping(value = "/lk")
    public Object readAccount() {
        UserAccount account = getAccount();
        log.info(String.format(request, "GET", config.getPort(),""));
        log.info(String.format("User %s coming to private room", account.getUsername()));
        if (account.getRole() == Role.PARTNER) {
            return new PrivateRoomResponseDTO(partnerService.readPartnerWithWorks(account.getAccountId()), EnumUtil.getListKeyValue(StateCarType.values()));
//            return partnerService.readPartnerWithWorks(account.getAccountId());
        }
        return clientService.readClient(account.getAccountId());
    }

    @Operation(summary = "Обновление информации в личном кабинет",
            security = @SecurityRequirement(name = "basic"))
    @PostMapping(value = "/lk")
    public StatusResponse updateAccount(@RequestBody Object accountData) {
        log.info(String.format(request, "POST", config.getPort(), ""));
        UserAccount account = getAccount();
        if (account.getRole() == Role.PARTNER) {
            PartnerRequestDTO requestDTO = mapper.convertValue(accountData, PartnerRequestDTO.class);
            partnerService.updatePartner(account.getAccountId(), requestDTO);
        } else {
            ClientDTO requestDTO = mapper.convertValue(accountData, ClientDTO.class);
            clientService.updateClient(account.getAccountId(), requestDTO);
        }
        log.info(String.format("User %s update info in private room", account.getUsername()));
        return StatusResponse.getOk();
    }

    @Operation(summary = "Создание и обновление списка услуг с их стоимостью",
            security = @SecurityRequirement(name = "basic"))
    @PostMapping(value = "/lk/works")
    public StatusResponse createAndUpdateCostWork(@RequestBody List<CostWorkRequestDTO> costWorks) {
        log.info(String.format(request, "POST", config.getPort(), "/works"));
        UserAccount account = getAccount();
        costWorkService.createAndUpdateCostsWorks(account.getAccountId(), costWorks);
        log.info(String.format("User %s update cost of works", account.getUsername()));
        return StatusResponse.getOk();
    }

    @Operation(summary = "Список услуг партнера",
            description = "Просмотр списка оказываемы услуг со стоимостью",
            security = @SecurityRequirement(name = "basic"))
    @GetMapping(value = "/lk/works")
    public List<CostWorkResponseDTO> readWorks() {
        UserAccount account = getAccount();
        log.info(String.format(request, "GET", config.getPort(), "/works"));
        log.info(String.format("User %s read list of works", account.getUsername()));
        return costWorkService.readCostsWorks(account.getAccountId());
    }

    @Operation(summary = "Список заказов",
            description = "Просмотр списка заказов, исполнителем который является данный партнер" +
                    "или создателем которых является данный клиент (будет сделано в дальнейшем)",
            security = @SecurityRequirement(name = "basic"))
    @GetMapping(value = "/lk/orders")
    public List<OrderResponseDTO> readOrders() {
        UserAccount account = getAccount();
        log.info(String.format(request, "GET", config.getPort(), "/orders"));
        log.info(String.format("User %s read list of orders", account.getUsername()));
        return orderService.readListOrders(account.getAccountId(), account.getRole());
    }

    @Operation(summary = "Изменение статуса заказа",
            description = "Изменение статуса заказа партнером из личного кабинета",
            security = @SecurityRequirement(name = "basic"))
    @PostMapping(value = "/lk/orders/{id}")
    public StatusResponse changeStatus(@PathVariable Long id, @RequestBody StateStatus status) {
        UserAccount account = getAccount();
        log.info(String.format(request, "POST", config.getPort(), "/orders/" + id));
        orderService.changeStatus(account.getAccountId(), id, status);
        log.info(String.format("User %s change status of order with id= %d", account.getUsername(), id));
        return StatusResponse.getOk();
    }
    @Operation(summary = "Загрузка фотографии сервиса",
            security = @SecurityRequirement(name = "basic"))
    @PostMapping(value = "/lk/images")
    public StatusResponse uploadImage(@RequestParam MultipartFile image) {
        UserAccount account = getAccount();
        log.info(String.format(request, "POST", config.getPort(), "/images"));
        imageService.uploadImage(account.getAccountId(), image);
        return StatusResponse.getOk();
    }
}
