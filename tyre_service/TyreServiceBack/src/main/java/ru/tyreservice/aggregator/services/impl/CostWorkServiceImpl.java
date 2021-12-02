package ru.tyreservice.aggregator.services.impl;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.tyreservice.aggregator.dto.requests.CostWorkRequestDTO;
import ru.tyreservice.aggregator.dto.responses.CostWorkResponseDTO;
import ru.tyreservice.aggregator.entities.CostWork;
import ru.tyreservice.aggregator.entities.Partner;
import ru.tyreservice.aggregator.repositories.CostWorkRepository;
import ru.tyreservice.aggregator.services.CostWorkService;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@AllArgsConstructor
@Service
public class CostWorkServiceImpl implements CostWorkService {
    private final CostWorkRepository costWorkRepository;

    @Override
    public List<CostWorkResponseDTO> readCostsWorks(Long id) {
        List<CostWork> listEntities = costWorkRepository.findAllByPartnerId(id);
        return listEntities.stream().map(CostWorkResponseDTO::fromEntity).collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void createAndUpdateCostsWorks(Long id, List<CostWorkRequestDTO> costWorkRequestDTOs) {
        Partner partner = new Partner();
        partner.setId(id);
        List<CostWork> deleteWorks = costWorkRequestDTOs.stream().filter(cw -> cw.getPrice() < 0).map(cw -> CostWorkRequestDTO.toEntity(partner, cw)).collect(Collectors.toList());
        List<CostWork> updateWorks = costWorkRequestDTOs.stream().filter(cw -> cw.getPrice() >= 0).map(cw -> CostWorkRequestDTO.toEntity(partner, cw)).collect(Collectors.toList());
        costWorkRepository.deleteAllInBatch(deleteWorks);
        costWorkRepository.saveAll(updateWorks);
    }
}
