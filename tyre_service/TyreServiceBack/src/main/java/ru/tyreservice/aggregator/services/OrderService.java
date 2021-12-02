package ru.tyreservice.aggregator.services;

import ru.tyreservice.aggregator.enums.Role;
import ru.tyreservice.aggregator.enums.StateStatus;
import ru.tyreservice.aggregator.dto.requests.OrderRequestDTO;
import ru.tyreservice.aggregator.dto.responses.OrderResponseDTO;

import java.util.List;

public interface OrderService {
    List<OrderResponseDTO> readListOrders(Long id, Role type);
    void changeStatus(Long partner, Long id, StateStatus status);
    Long createOrder(OrderRequestDTO orderRequest, Long clientId);
}
