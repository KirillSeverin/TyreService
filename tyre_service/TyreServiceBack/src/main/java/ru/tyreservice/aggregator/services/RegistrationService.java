package ru.tyreservice.aggregator.services;

import ru.tyreservice.aggregator.dto.requests.RegDataRequest;

public interface RegistrationService {
    void register(RegDataRequest request);
}
