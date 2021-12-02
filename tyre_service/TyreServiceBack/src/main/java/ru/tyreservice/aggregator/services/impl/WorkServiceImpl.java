package ru.tyreservice.aggregator.services.impl;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import ru.tyreservice.aggregator.dto.requests.WorkRequestDTO;
import ru.tyreservice.aggregator.dto.responses.WorkResponseDTO;
import ru.tyreservice.aggregator.entities.Work;
import ru.tyreservice.aggregator.repositories.WorkRepository;
import ru.tyreservice.aggregator.services.WorkService;

import java.util.List;
import java.util.stream.Collectors;

@AllArgsConstructor
@Slf4j
@Service
public class WorkServiceImpl implements WorkService {
    private WorkRepository workRepository;

    @Override
    public List<WorkResponseDTO> readListWorks() {
        return workRepository.findAll().stream().map(WorkResponseDTO::fromEntity).collect(Collectors.toList());
    }

    @Override
    public Long createWork(WorkRequestDTO requestDTO) {
        Work work = WorkRequestDTO.toEntity(requestDTO);
        return workRepository.save(work).getId();
    }
}
