package ru.tyreservice.aggregator.repositories;

import org.springframework.data.repository.CrudRepository;
import ru.tyreservice.aggregator.entities.User;

import java.util.Optional;

public interface UserRepository extends CrudRepository<User, Long> {
    Optional<User> findByLogin(String login);
}
