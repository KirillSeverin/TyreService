package ru.tyreservice.aggregator.services.impl;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.tyreservice.aggregator.dto.requests.CostWorkRequestDTO;
import ru.tyreservice.aggregator.dto.requests.PartnerRequestDTO;
import ru.tyreservice.aggregator.dto.responses.PartnerResponseDTO;
import ru.tyreservice.aggregator.dto.responses.PartnerWithDetailsResponseDTO;
import ru.tyreservice.aggregator.entities.CostWork;
import ru.tyreservice.aggregator.entities.Partner;
import ru.tyreservice.aggregator.enums.StateCarType;
import ru.tyreservice.aggregator.exceptions.NotFoundException;
import ru.tyreservice.aggregator.repositories.PartnerRepository;
import ru.tyreservice.aggregator.services.PartnerService;
import ru.tyreservice.aggregator.utils.GlobalConfig;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Service
@AllArgsConstructor
public class PartnerServiceImpl implements PartnerService {
    private final PartnerRepository repository;
    private final GlobalConfig config;

    @Override
    public List<PartnerResponseDTO> readListPartners(StateCarType type, String name, List<Long> ids, Integer page, Double latitude, Double longitude) {
        int numberPage = page == null ? 0 : page;
        Pageable pageable = PageRequest.of(numberPage, config.getSizePage());
        long count = ids == null ? 0 : ids.size();
        latitude = latitude == null ? 0.0 : latitude;
        longitude = longitude == null ? 0.0 : longitude;
        name = name == null ? "" : name;
        Page<Partner> pagePartners = repository.findAllByFilter(pageable, type, name, ids, count, latitude, longitude);
        List<Partner> partners = pagePartners.getContent();
        return partners.stream().map(PartnerResponseDTO::fromEntity).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public PartnerWithDetailsResponseDTO readPartnerWithWorks(Long id) {
        Partner partner = findById(id);
        return PartnerWithDetailsResponseDTO.fromEntity(partner);
    }

    @Override
    @Transactional
    public void updatePartner(Long id, PartnerRequestDTO partnerRequest) {
        Partner partner = findById(id);

        String value = partnerRequest.getName();
        if (!StringUtils.isBlank(value)) {
            partner.setName(value);
        }
        value = partnerRequest.getDescription();
        if (!StringUtils.isBlank(value)) {
            partner.setDescription(value);
        }
        value = partnerRequest.getEmail();
        if (!StringUtils.isBlank(value)) {
            partner.setEmail(value);
        }
        value = partnerRequest.getPhone();
        if (!StringUtils.isBlank(value)) {
            partner.setPhone(value);
        }
        value = partnerRequest.getAddress();
        if (!StringUtils.isBlank(value)) {
            partner.setAddress(value);
        }
        value = partnerRequest.getSchedule();
        if (!StringUtils.isBlank(value)) {
            partner.setSchedule(value);
        }

        Double coordinate = partnerRequest.getLatitude();
        if (coordinate != null) {
            partner.setLatitude(coordinate);
        }
        coordinate = partnerRequest.getLongitude();
        if (coordinate != null) {
            partner.setLongitude(coordinate);
        }

        StateCarType type = partnerRequest.getCarType();
        if (type != null) {
            partner.setCarType(type);
        }

        Set<CostWorkRequestDTO> works = partnerRequest.getWorks();
        if (works != null) {
            Set<CostWork> oldWorks = partner.getCostsWorks();
            Set<CostWork> deleteNewWorks = works.stream().map(w -> CostWorkRequestDTO.toEntity(partner, w)).collect(Collectors.toSet());
            Set<CostWork> updateNewWorks = works.stream().filter(w -> w.getPrice() >= 0).map(w -> CostWorkRequestDTO.toEntity(partner, w)).collect(Collectors.toSet());
            oldWorks.removeAll(deleteNewWorks);
            oldWorks.addAll(updateNewWorks);
        }
    }

    @Override
    public Long createNewPartner(String email, String phone, String name) {
        Partner partner = new Partner();
        partner.setName(name);
        partner.setEmail(email);
        partner.setPhone(phone);
        partner.setCarType(StateCarType.PASSENGER);
        return repository.save(partner).getId();
    }

    @Override
    public Partner findById(Long id) {
        Optional<Partner> optional = repository.findById(id);
        return optional.orElseThrow(() -> new NotFoundException("Партнера с указанным идентификатором не существует"));
    }
}
