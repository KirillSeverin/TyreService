package ru.tyreservice.aggregator.exceptions;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class UserExistsException extends RuntimeException{
    private String error;
}
