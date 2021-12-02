package ru.tyreservice.aggregator.dto.responses;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.LineOrder;

@Getter@Setter
@Schema(description = "Наименование, стоимость и количество услуг в заказе")
public class LineOrderResponseDTO {
    //наименование услуги из общего справочника
    @Schema(description = "id услуги из общего справочника")
    private Long id;
    @Schema(description = "Наименование услуги из общего справочника")
    private String name;
    //стоимость услуги из справочника партнера
    @Schema(description = "Стоимость услуги")
    private Integer price;
    @Schema(description = "Количество")
    private Integer count;

    public static LineOrderResponseDTO fromEntity(LineOrder lineOrder) {
        LineOrderResponseDTO line = new LineOrderResponseDTO();
        line.setId(lineOrder.getWork().getId());
        line.setName(lineOrder.getWork().getName());
        line.setPrice(lineOrder.getPrice());
        line.setCount(lineOrder.getCount());
        return line;
    }
}
