package ru.tyreservice.aggregator.exceptions;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
public class NullValueFieldException extends RuntimeException {
    private List<String> errors;
}
