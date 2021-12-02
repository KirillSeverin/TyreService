package ru.tyreservice.aggregator.entities;

import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.enums.StateWheelType;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Table(name = "works")
public class Work {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private String name;
    private String description;
    @Column(name = "type")
    @Enumerated(value = EnumType.STRING)
    private StateWheelType stateWheelType;
}
