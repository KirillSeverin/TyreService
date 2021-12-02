package ru.tyreservice.aggregator.entities;

import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.enums.Role;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private String login;
    @Column(nullable = false)
    private String password;
    @Column(nullable = false, name = "account")
    private Long accountId;
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private Role role;

    public User(String login, String password, Long accountId, Role role) {
        this.login = login;
        this.password = password;
        this.accountId = accountId;
        this.role = role;
    }

    public User() {
    }
}
