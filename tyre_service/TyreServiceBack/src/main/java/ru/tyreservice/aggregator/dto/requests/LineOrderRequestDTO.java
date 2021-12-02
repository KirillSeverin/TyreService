package ru.tyreservice.aggregator.dto.requests;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.LineOrder;
import ru.tyreservice.aggregator.entities.Work;

@Getter
@Setter
@Schema(description = "Наименование, стоимость и количество услуг в заказе")
public class LineOrderRequestDTO {
    //id услуги из общего справочника
    @Schema(description = "Услуга из общего справочника")
    private Long id;
    //стоимость услуги из справочника партнера
    @Schema(description = "Стоимость услуги")
    private Integer price;
    @Schema(description = "Количество")
    private Integer count;

    public static LineOrder toEntity(LineOrderRequestDTO lineOrder) {
        LineOrder line = new LineOrder();
        Work work = new Work();
        work.setId(lineOrder.getId());
        line.setWork(work);
        line.setPrice(lineOrder.getPrice());
        line.setCount(lineOrder.getCount());
        return line;
    }
}
