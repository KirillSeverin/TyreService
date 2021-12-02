package ru.tyreservice.aggregator.dto.requests;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

@Setter@Getter
@Schema(description = "Информация о клиенте")
public class ClientDTO {
    @Schema(description = "Имя клиента")
    private String name;
    @Schema(description = "Электронная почта")
    private String email;
    @Schema(description = "Телефон")
    private String phone;
}
