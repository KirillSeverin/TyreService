package ru.tyreservice.aggregator.dto.responses;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;

import java.util.List;

@Getter
@Schema(description = "Ответ сервера, при пост запросах")
public class StatusResponse {
    @Schema(description = "Статус выполнения")
    private boolean success;
    @Schema(description = "Список ошибок в случае неудачного завершения запроса")
    private List<String> errors;

    public StatusResponse(boolean success) {
        this.success = success;
    }

    public StatusResponse(boolean success, List<String> errors) {
        this.success = success;
        this.errors = errors;
    }

    public static StatusResponse getOk() {
        return new StatusResponse(true);
    }

    public static StatusResponse getBad(List<String> errors) {
        return new StatusResponse(false, errors);
    }
}
