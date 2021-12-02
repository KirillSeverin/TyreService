package ru.tyreservice.aggregator.dto.responses;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.Order;
import ru.tyreservice.aggregator.enums.StateStatus;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;
import java.util.stream.Collectors;

@Getter@Setter
@Schema(description = "Информация о ранее созданном заказе")
public class OrderResponseDTO {
    //Основная информация о заказе
    @Schema(description = "Идентификатор заказа")
    private Long id;
    @Schema(description = "Партнер исполнитель")
    private String partner_name;
    @Schema(description = "Дата создания")
    private Date createDate;
    @Schema(description = "Дата бронирования")
    private Date bookingDate;
    @Schema(description = "Статус исполнения")
    private StateStatus status;
    //инфомация о клиенте
    @Schema(description = "Имя клиента")
    private String clientName;
    @Schema(description = "Номер телефона клиента")
    private String clientPhone;
    @Schema(description = "Автомобиль")
    private String auto;
    //полная стоимость заказа
    private Integer fullPrice;
    //табличная часть заказа, строки с наименованием услуги, стоимостью и количеством
    @Schema(description = "Список указанных клиентом услуг")
    Set<LineOrderResponseDTO> lines;

    public static OrderResponseDTO fromEntity(Order order) {
        OrderResponseDTO orderResponse = new OrderResponseDTO();
        orderResponse.setId(order.getId());
        orderResponse.setPartner_name(order.getPartner().getName());
        orderResponse.setCreateDate(order.getCreateDate());
        orderResponse.setBookingDate((order.getBookingDate()));
        orderResponse.setStatus(order.getStatus());
        orderResponse.setClientName(order.getClientName());
        orderResponse.setClientPhone(order.getClientPhone());
        orderResponse.setAuto(order.getClientAuto());
        orderResponse.setFullPrice(orderResponse.getFullPrice());
        orderResponse.setFullPrice(order.getLines().stream().mapToInt(l -> l.getPrice() * l.getCount()).sum());
        orderResponse.setLines(order.getLines().stream().map(LineOrderResponseDTO::fromEntity).collect(Collectors.toSet()));
        return orderResponse;
    }
}
