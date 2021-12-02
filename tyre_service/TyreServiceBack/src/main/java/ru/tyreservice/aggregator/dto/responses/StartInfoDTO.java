package ru.tyreservice.aggregator.dto.responses;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import ru.tyreservice.aggregator.enums.EnumUtil;

import java.util.List;

@AllArgsConstructor
@Getter
@Schema(description = "Общая информация для отображения на главной страницы")
public class StartInfoDTO {
    @Schema(description = "Типы сервисов")
    private List<EnumUtil.KeyValue> types;
    @Schema(description = "Статусы заказов")
    private List<EnumUtil.KeyValue> statuses;
    @Schema(description = "Типы учетных записей Клиент/Партнер")
    private List<EnumUtil.KeyValue> lks;
    @Schema(description = "Список всех услуг")
    private List<WorkResponseDTO> works;
    @Schema(description = "Список партнеров с краткой информацией")
    private List<PartnerResponseDTO> partners;
}
