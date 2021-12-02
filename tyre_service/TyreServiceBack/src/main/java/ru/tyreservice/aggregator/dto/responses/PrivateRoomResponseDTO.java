package ru.tyreservice.aggregator.dto.responses;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.enums.EnumUtil;

import java.util.List;
@Getter@Setter
@AllArgsConstructor
public class PrivateRoomResponseDTO {
    private PartnerWithDetailsResponseDTO lk;
    private List<EnumUtil.KeyValue> types;
}
