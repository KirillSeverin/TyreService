package ru.tyreservice.aggregator.dto.requests;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.enums.Role;

@Getter@Setter
@Schema(description = "Необходимая информация при регистрации")
public class RegDataRequest {
    @Schema(description = "Электронная почта, она же логин")
    private String email;
    @Schema(description = "Пароль")
    private String password;
    @Schema(description = "Имя клиента или наименование партнера")
    private String name;
    @Schema(description = "Телефон")
    private String phone;
    @Schema(description = "Тип учетной записи")
    private Role type;
}
