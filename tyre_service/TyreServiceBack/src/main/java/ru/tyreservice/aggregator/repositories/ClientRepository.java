package ru.tyreservice.aggregator.repositories;

import org.springframework.data.repository.CrudRepository;
import ru.tyreservice.aggregator.entities.Client;
import ru.tyreservice.aggregator.entities.User;

import java.util.Optional;

public interface ClientRepository extends CrudRepository<Client, Long> {
}
