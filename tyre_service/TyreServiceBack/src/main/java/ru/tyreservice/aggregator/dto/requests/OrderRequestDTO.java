package ru.tyreservice.aggregator.dto.requests;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.Order;
import ru.tyreservice.aggregator.entities.Partner;
import ru.tyreservice.aggregator.enums.StateStatus;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;
import java.util.stream.Collectors;

@Getter@Setter
@Schema(description = "Информация о создаваемом заказе")
public class OrderRequestDTO {
    //Основная информация о заказе
    @Schema(description = "Партнер исполнитель")
    private Long partnerId;
    @Schema(description = "Дата бронирования")
    private Date bookingDate;
    //информация о клиенте
    @Schema(description = "Имя клиента")
    private String clientName;
    @Schema(description = "Номер телефона клиента")
    private String clientPhone;
    @Schema(description = "Автомобиль")
    private String clientAuto;
    //табличная часть заказа, строки с наименованием услуги, стоимостью и количеством
    @Schema(description = "Список необходимых услуг")
    Set<LineOrderRequestDTO> lines;

    public static Order toEntity(OrderRequestDTO orderRequest) {
        Order order = new Order();
        Partner partner = new Partner();
        partner.setId(orderRequest.getPartnerId());
        order.setPartner(partner);
        order.setCreateDate(new Date());
        order.setBookingDate((orderRequest.getBookingDate()));
        order.setStatus(StateStatus.WAITING);
        order.setClientName(orderRequest.getClientName());
        order.setClientPhone(orderRequest.getClientPhone());
        order.setClientAuto(orderRequest.getClientAuto());
        order.setLines(orderRequest.getLines().stream().map(LineOrderRequestDTO::toEntity).collect(Collectors.toSet()));
        return order;
    }
}