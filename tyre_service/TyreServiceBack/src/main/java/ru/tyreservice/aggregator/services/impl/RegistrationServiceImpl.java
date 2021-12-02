package ru.tyreservice.aggregator.services.impl;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.tyreservice.aggregator.dto.requests.RegDataRequest;
import ru.tyreservice.aggregator.dto.responses.StatusResponse;
import ru.tyreservice.aggregator.enums.Role;
import ru.tyreservice.aggregator.exceptions.NullValueFieldException;
import ru.tyreservice.aggregator.exceptions.UserExistsException;
import ru.tyreservice.aggregator.services.ClientService;
import ru.tyreservice.aggregator.services.PartnerService;
import ru.tyreservice.aggregator.services.RegistrationService;
import ru.tyreservice.aggregator.services.UserService;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Slf4j
@AllArgsConstructor
@Service
public class RegistrationServiceImpl implements RegistrationService {
    private final PasswordEncoder  passwordEncoder;
    private final UserService userService;
    private final PartnerService partnerService;
    private final ClientService clientService;

    @Override
    @Transactional
    public void register(RegDataRequest request) {
        String email = request.getEmail();
        Role role = request.getType() == null ? Role.PARTNER : request.getType();
        try {
            userService.findUserByLogin(email);
            throw new UserExistsException("Пользователь с указанным именем существует. Выберите другое имя");
        } catch (RuntimeException e) {
            String password = request.getPassword();
            String phone = request.getPhone();
            String name = request.getName();
            List<String> errors = new ArrayList<>(4);

            if (StringUtils.isBlank(email)) {
                errors.add("Поле ЭЛЕКТРОНАЯ ПОЧТА должно быть заполнено");
            }
            if (StringUtils.isBlank(password)) {
                errors.add("Поле ПАРОЛЬ должно быть заполнено");
            }
            if (StringUtils.isBlank(name)) {
                errors.add(String.format("Поле %s должно быть заполнено", role == Role.PARTNER ? "НАИМЕНОВАНИЕ" : "ИМЯ"));
            }
            if (StringUtils.isBlank(phone)) {
                errors.add("Поле ТЕЛЕФОН должно быть заполнено");
            }
            if (!errors.isEmpty()) {
                throw new NullValueFieldException(errors);
            }
            Long id;
            if (role == Role.PARTNER) {
                id = partnerService.createNewPartner(email, phone, name);
                log.info(String.format("Create partner's private room with id=%d ", id));
                userService.createUser(email, passwordEncoder.encode(password), Role.PARTNER, id);
            } else {
                id = clientService.createNewClient(email, phone, name);
                log.info(String.format("Create client's private room with id=%d ", id));
                userService.createUser(email, passwordEncoder.encode(password), Role.CLIENT, id);
            }
            log.info(String.format("Create user with name=%s ", name));
        }
    }
}
