package ru.tyreservice.aggregator.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping
public class SwaggerController {

    @GetMapping
    public String handleSwagger() {
        return "redirect:/swagger-ui.html";
    }

}
