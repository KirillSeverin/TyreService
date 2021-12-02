package ru.tyreservice.aggregator.services.impl;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import ru.tyreservice.aggregator.dto.responses.PartnerResponseDTO;
import ru.tyreservice.aggregator.dto.responses.StartInfoDTO;
import ru.tyreservice.aggregator.dto.responses.StatusResponse;
import ru.tyreservice.aggregator.dto.responses.WorkResponseDTO;
import ru.tyreservice.aggregator.enums.EnumUtil;
import ru.tyreservice.aggregator.enums.Role;
import ru.tyreservice.aggregator.enums.StateCarType;
import ru.tyreservice.aggregator.enums.StateStatus;
import ru.tyreservice.aggregator.services.PartnerService;
import ru.tyreservice.aggregator.services.StartService;
import ru.tyreservice.aggregator.services.WorkService;

import java.util.List;

@Slf4j
@AllArgsConstructor
@Service
public class StartServiceImpl implements StartService {
    private final WorkService workService;
    private final PartnerService partnerService;

    @Override
    public StartInfoDTO readStartInfo() {
        List<EnumUtil.KeyValue> statuses = EnumUtil.getListKeyValue(StateStatus.values());
        List<EnumUtil.KeyValue> types = EnumUtil.getListKeyValue(StateCarType.values());
        List<EnumUtil.KeyValue> lks = EnumUtil.getListKeyValue(new Role[]{Role.PARTNER, Role.CLIENT});
        List<PartnerResponseDTO> partners = partnerService.readListPartners(null, null, null, null, 0.0, 0.0);
        List<WorkResponseDTO> works = workService.readListWorks();
        return new StartInfoDTO(types, statuses, lks, works, partners);
    }
}
