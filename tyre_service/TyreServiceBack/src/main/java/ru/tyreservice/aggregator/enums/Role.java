package ru.tyreservice.aggregator.enums;

import io.swagger.v3.oas.annotations.Hidden;
import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority, Nameable {

    CLIENT("Клиент"),
    PARTNER("Партнер"),
    MANAGER("Менеджер"),
    ADMIN("");

    private String name;

    Role(String name) {
        this.name = name;
    }

    @Override
    public String getAuthority() {
        return this.toString();
    }

    @Override
    public String getName() {
        return name;
    }
}
