package ru.tyreservice.aggregator.dto.requests;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.CostWork;
import ru.tyreservice.aggregator.entities.Partner;
import ru.tyreservice.aggregator.entities.Work;

@Getter@Setter
@Schema(description = "Стоимость указанной услуги")
public class CostWorkRequestDTO {
    //id услуги из общего справочника услуг
    @Schema(description = "Услуга из общего справочника")
    private Long id;
    //стоимость услуги, которую устанавливает партнер
    @Schema(description = "Стоимость услуги")
    private Long price;

    public static CostWork toEntity(Partner partner, CostWorkRequestDTO costWorkRequestDTO) {
        Work work = new Work();
        work.setId(costWorkRequestDTO.id);
        return new CostWork(partner, work, costWorkRequestDTO.getPrice());
    }
}
