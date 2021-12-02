package ru.tyreservice.aggregator.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public enum StateCarType implements Nameable {
    PASSENGER( "Легковые"),
    OFFROAD("Внедорожники"),
    TRUCK("Грузовые");

    private String name;

    StateCarType(String name) {
        this.name = name;
    }

    @Override
    public String getName() {
        return name;
    }
}
