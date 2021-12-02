package ru.tyreservice.aggregator.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import ru.tyreservice.aggregator.dto.responses.StatusResponse;
import ru.tyreservice.aggregator.exceptions.ImageNotSaveException;
import ru.tyreservice.aggregator.exceptions.NotFoundException;
import ru.tyreservice.aggregator.exceptions.NullValueFieldException;
import ru.tyreservice.aggregator.exceptions.UserExistsException;

import java.util.Collections;

@RestControllerAdvice
public class HandlerExceptionController {

    @ExceptionHandler(value = NotFoundException.class)
    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    public StatusResponse handleNotFoundException(NotFoundException e) {
        return StatusResponse.getBad(Collections.singletonList(e.getError()));
    }

    @ExceptionHandler(value = NullValueFieldException.class)
    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    public StatusResponse handleNullValueFieldException(NullValueFieldException e) {
        return StatusResponse.getBad(e.getErrors());
    }

    @ExceptionHandler(value = UserExistsException.class)
    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    public StatusResponse handleUserExistsException(UserExistsException e) {
        return StatusResponse.getBad(Collections.singletonList(e.getError()));
    }

    @ExceptionHandler(value = ImageNotSaveException.class)
    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    public StatusResponse handleImageNotSaveException(ImageNotSaveException e) {
        return StatusResponse.getBad(Collections.singletonList(e.getError()));
    }
}
