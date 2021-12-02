package ru.tyreservice.aggregator.dto.responses;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.Work;

@Getter
@Setter
@Schema(description = "Информация об услуге из общего справочника")
public class WorkResponseDTO {
    //наименование услуги из общего справочника
    @Schema(description = "id, используется при формировании заказа и при фильтрации списка партнеров")
    private Long id;
    @Schema(description = "Наименование услуги")
    private String name;
    @Schema(description = "Подробное описание услуги")
    private String description;

    public static WorkResponseDTO fromEntity(Work work) {
        WorkResponseDTO workResponse = new WorkResponseDTO();
        workResponse.setId(work.getId());
        workResponse.setName(work.getName());
        workResponse.setDescription(work.getDescription());
        return workResponse;
    }
}
