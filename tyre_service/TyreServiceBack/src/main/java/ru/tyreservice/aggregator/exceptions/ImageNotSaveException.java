package ru.tyreservice.aggregator.exceptions;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class ImageNotSaveException extends RuntimeException{
    private String error;
}
