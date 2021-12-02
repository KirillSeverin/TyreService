package ru.tyreservice.aggregator.security;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.tyreservice.aggregator.entities.User;
import ru.tyreservice.aggregator.services.UserService;

import java.util.Collections;


@Slf4j
@AllArgsConstructor
@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    private final UserService service;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
            User user = service.findUserByLogin(username);
            UserAccount userAccount = new UserAccount(user.getLogin(), user.getPassword(),
                    Collections.singleton(user.getRole()), user.getAccountId());
            return userAccount;
        } catch (RuntimeException e) {
            throw new UsernameNotFoundException(username);
        }
    }
}
