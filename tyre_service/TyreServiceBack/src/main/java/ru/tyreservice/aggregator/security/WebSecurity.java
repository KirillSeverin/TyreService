package ru.tyreservice.aggregator.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class WebSecurity extends WebSecurityConfigurerAdapter {

    private final UserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;

    public WebSecurity(UserDetailsService userDetailsService, PasswordEncoder passwordEncoder) {
        this.userDetailsService = userDetailsService;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .authorizeRequests()
            .antMatchers("/api/lk/works").hasAnyAuthority("PARTNER", "MANAGER")
            .antMatchers(HttpMethod.GET, "/api/lk/orders").hasAnyAuthority("CLIENT", "PARTNER", "MANAGER")
            .antMatchers(HttpMethod.POST, "/api/lk/orders/*").hasAnyAuthority("PARTNER", "MANAGER")
            .antMatchers(HttpMethod.POST, "/api/lk/images").hasAnyAuthority("PARTNER", "MANAGER")
            .antMatchers("/api/lk", "/api/login").hasAnyAuthority("CLIENT", "PARTNER", "MANAGER")
            .antMatchers(HttpMethod.GET, "/api/works").hasAnyAuthority("ADMIN", "PARTNER", "MANAGER")
            .antMatchers(HttpMethod.POST, "/api/works").hasAnyAuthority("ADMIN")
            .antMatchers("/api/**").permitAll()
            .and().httpBasic();

//        http.sessionManagement().maximumSessions(1);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
    }
}
