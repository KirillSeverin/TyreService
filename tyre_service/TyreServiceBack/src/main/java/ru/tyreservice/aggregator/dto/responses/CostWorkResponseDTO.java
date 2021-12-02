package ru.tyreservice.aggregator.dto.responses;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.CostWork;

@Getter@Setter
@Schema(description = "Стоимость указанной услуги")
public class CostWorkResponseDTO {
    //id и наименование услуги из общего справочника услуг
    @Schema(description = "id услуги из общего справочника")
    private Long id;
    @Schema(description = "Наименование услуги из общего справочника")
    private String name;
    //стоимость услуги, которую устанавливает партнер
    @Schema(description = "Стоимость услуги")
    private Long price;

    public static CostWorkResponseDTO fromEntity(CostWork costWork) {
        CostWorkResponseDTO costWorkResponse = new CostWorkResponseDTO();
        costWorkResponse.setId(costWork.getWork().getId());
        costWorkResponse.setName(costWork.getWork().getName());
        costWorkResponse.setPrice(costWork.getPrice());
        return costWorkResponse;
    }
}
