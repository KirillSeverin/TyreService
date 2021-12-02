package ru.tyreservice.aggregator.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

public class SecurityUtil {
    private SecurityUtil() {
    }

    public static UserAccount getAccount() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return ((UserAccount)authentication.getPrincipal());
    }

    public static boolean isAnonymous() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authentication.getName().equals("anonymousUser");
    }
}
