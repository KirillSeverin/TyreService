package ru.tyreservice.aggregator.dto.responses;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.Partner;
import ru.tyreservice.aggregator.entities.Review;

import java.util.*;
import java.util.stream.Collectors;

@Getter@Setter
@Schema(description = "Подробная информация о партнере с услугами")
public class PartnerWithDetailsResponseDTO extends PartnerResponseDTO {
    @Schema(description = "Список оказываемых услуг со стоимостью")
    private Set<CostWorkResponseDTO> works;
    @Schema(description = "Отзывы")
    private List<Review> reviews;

    public static PartnerWithDetailsResponseDTO fromEntity(Partner partner) {
        PartnerWithDetailsResponseDTO partnerResponseDTO = new PartnerWithDetailsResponseDTO();
        partnerResponseDTO.inputFields(partner);
        partnerResponseDTO.setWorks(new LinkedHashSet<>(partner.getCostsWorks().stream().map(CostWorkResponseDTO::fromEntity)
                .sorted(Comparator.comparing(CostWorkResponseDTO::getName)).collect(Collectors.toList())));
        partnerResponseDTO.setReviews(partner.getReviews().stream().sorted(Comparator.comparing(Review::getDate).reversed()).collect(Collectors.toList()));
        return partnerResponseDTO;
    }
}