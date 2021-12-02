package ru.tyreservice.aggregator.services.impl;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.tyreservice.aggregator.enums.Role;
import ru.tyreservice.aggregator.enums.StateStatus;
import ru.tyreservice.aggregator.dto.requests.OrderRequestDTO;
import ru.tyreservice.aggregator.dto.responses.OrderResponseDTO;
import ru.tyreservice.aggregator.entities.Order;
import ru.tyreservice.aggregator.exceptions.NotFoundException;
import ru.tyreservice.aggregator.repositories.OrderRepository;
import ru.tyreservice.aggregator.services.OrderService;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@AllArgsConstructor
@Service
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;

    @Override
    @Transactional
    public void changeStatus(Long partner, Long id, StateStatus status) {
        Order order = readById(id);
        if (!order.getPartner().getId().equals(partner)) {
            throw new NotFoundException(String.format("Исполнителем заказа с id=%d является другая организация. " +
                    "Отказано в изменении статуса", id));
        }
        order.setStatus(status);
    }

    @Override
    public List<OrderResponseDTO> readListOrders(Long id, Role type) {
        List<Order> listEntities = type == Role.PARTNER
                ? orderRepository.findAllByPartnerId(id) : orderRepository.findAllByClientId(id);
        return listEntities.stream().map(OrderResponseDTO::fromEntity)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public Long createOrder(OrderRequestDTO orderRequest, Long clientId) {
        Order order = OrderRequestDTO.toEntity(orderRequest);
        order.setClientId(clientId);
        return orderRepository.save(order).getId();
    }

    private Order readById(Long id) {
        return orderRepository.findById(id).orElseThrow(
                () -> new NotFoundException(String.format("Заказ с id=%d не найден", id)));
    }
}
