package ru.tyreservice.aggregator.services;

import ru.tyreservice.aggregator.dto.responses.StartInfoDTO;

public interface StartService {
    StartInfoDTO readStartInfo();
}
