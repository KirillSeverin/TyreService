package ru.tyreservice.aggregator.services;

import ru.tyreservice.aggregator.dto.requests.WorkRequestDTO;
import ru.tyreservice.aggregator.dto.responses.WorkResponseDTO;

import java.util.List;

public interface WorkService {
    List<WorkResponseDTO> readListWorks();
    Long createWork(WorkRequestDTO requestDTO);
}
