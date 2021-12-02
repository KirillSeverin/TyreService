package ru.tyreservice.aggregator.dto.responses;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.Partner;
import ru.tyreservice.aggregator.enums.StateCarType;

@Getter@Setter
@Schema(description = "Краткая информация о партнере для списка")
public class PartnerResponseDTO {
    @Schema(description = "Идентификатор партнера")
    private Long id;
    @Schema(description = "Наименование партнера")
    private String name;
    @Schema(description = "Описание о партнере")
    private String description;
    @Schema(description = "Электронная почта")
    private String email;
    @Schema(description = "Режим работы")
    private String schedule;
    @Schema(description = "Номер телефона")
    private String phone;
    @Schema(description = "Ранг")
    private Double rank;
    @Schema(description = "Адрес")
    private String address;
    @Schema(description = "Координаты. Широта")
    private Double latitude;
    @Schema(description = "Координаты. Долгота")
    private Double longitude;
    @Schema(description = "Тип сервиса")
    private StateCarType carType;
    @Schema(description = "Имя файла с изображением сервиса")
    private String imageName;

    public static PartnerResponseDTO fromEntity(Partner partner) {
        PartnerResponseDTO partnerResponseDTO = new PartnerResponseDTO();
        partnerResponseDTO.inputFields(partner);
        return partnerResponseDTO;
    }

    protected void inputFields(Partner partner) {
        this.setId(partner.getId());
        this.setName(partner.getName());
        this.setDescription(partner.getDescription());
        this.setEmail(partner.getEmail());
        this.setSchedule(partner.getSchedule());
        this.setPhone(partner.getPhone());
        this.setRank(partner.getRank());
        this.setAddress(partner.getAddress());
        this.setLatitude(partner.getLatitude());
        this.setLongitude(partner.getLongitude());
        this.setCarType(partner.getCarType());
        this.setImageName(partner.getImageName());
    }
}