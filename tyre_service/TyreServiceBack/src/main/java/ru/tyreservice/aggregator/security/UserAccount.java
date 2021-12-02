package ru.tyreservice.aggregator.security;

import lombok.Getter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import ru.tyreservice.aggregator.enums.Role;

import java.util.Collection;

@Getter
public class UserAccount extends User {
    //идентификатор личного кабинета пользователя
    private final Long accountId;

    public UserAccount(String username, String password, Collection<? extends GrantedAuthority> authorities, Long accountId) {
        super(username, password, authorities);
        this.accountId = accountId;
    }

    public Role getRole() {
        return (Role)getAuthorities().iterator().next();
    }
}
