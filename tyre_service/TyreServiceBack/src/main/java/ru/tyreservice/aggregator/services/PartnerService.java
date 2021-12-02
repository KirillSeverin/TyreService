package ru.tyreservice.aggregator.services;

import ru.tyreservice.aggregator.dto.requests.PartnerRequestDTO;
import ru.tyreservice.aggregator.dto.responses.PartnerResponseDTO;
import ru.tyreservice.aggregator.dto.responses.PartnerWithDetailsResponseDTO;
import ru.tyreservice.aggregator.entities.Partner;
import ru.tyreservice.aggregator.enums.StateCarType;

import java.util.List;

public interface PartnerService {
    List<PartnerResponseDTO> readListPartners(StateCarType type, String name, List<Long> ids, Integer page, Double latitude, Double longitude);
    PartnerWithDetailsResponseDTO readPartnerWithWorks(Long id);
    void updatePartner(Long id, PartnerRequestDTO partnerRequestDTO);
    Long createNewPartner(String email, String phone, String name);
    Partner findById(Long id);
}
