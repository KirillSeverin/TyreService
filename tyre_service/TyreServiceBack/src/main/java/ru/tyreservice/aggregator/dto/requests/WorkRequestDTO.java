package ru.tyreservice.aggregator.dto.requests;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.Work;

@Getter@Setter
@Schema(description = "Информация о создаваемой услуге")
public class WorkRequestDTO {
    @Schema(description = "Наименование услуги")
    private String name;
    @Schema(description = "Подробное описание услуги")
    private String description;

    public static Work toEntity(WorkRequestDTO workRequestDTO) {
        Work work = new Work();
        work.setName(workRequestDTO.getName());
        work.setDescription(workRequestDTO.getDescription());
        return work;
    }
}
