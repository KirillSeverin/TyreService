package ru.tyreservice.aggregator.services.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.tyreservice.aggregator.entities.User;
import ru.tyreservice.aggregator.enums.Role;
import ru.tyreservice.aggregator.repositories.UserRepository;
import ru.tyreservice.aggregator.services.UserService;
import ru.tyreservice.aggregator.utils.GlobalConfig;

@Slf4j
@Service
public class UserServiceImpl implements UserService {
    private final User admin;
    private final UserRepository repository;

    public UserServiceImpl(UserRepository repository,
                           PasswordEncoder passwordEncoder,
                           GlobalConfig config) {
        this.repository = repository;
        this.admin = new User(config.getAdminLogin(),
                passwordEncoder.encode(config.getAdminPassword()), null, Role.ADMIN);
    }

    @Override
    public User findUserByLogin(String login) {
        if (login.equals(admin.getLogin())) {
            return admin;
        }
        return repository.findByLogin(login).orElseThrow(RuntimeException::new);
    }

    @Override
    public Long createUser(String login, String password, Role role, Long accountId) {
        User user = new User(login, password, accountId, role);
        return repository.save(user).getId();
    }
}
