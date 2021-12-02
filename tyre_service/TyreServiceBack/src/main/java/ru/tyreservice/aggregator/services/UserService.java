package ru.tyreservice.aggregator.services;

import ru.tyreservice.aggregator.enums.Role;
import ru.tyreservice.aggregator.entities.User;

public interface UserService {
    User findUserByLogin(String login);
    Long createUser(String login, String password, Role role, Long accountId);
}
