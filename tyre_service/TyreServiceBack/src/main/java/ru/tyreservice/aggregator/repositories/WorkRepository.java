package ru.tyreservice.aggregator.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.tyreservice.aggregator.entities.Work;

public interface WorkRepository extends JpaRepository<Work, Long> {
}
