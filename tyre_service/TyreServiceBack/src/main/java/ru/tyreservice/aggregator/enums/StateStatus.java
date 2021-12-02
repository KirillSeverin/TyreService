package ru.tyreservice.aggregator.enums;


public enum StateStatus implements Nameable {
    CANCEL("Отменен"),
    DONE("Выполнен"),
    WAITING("Создан");

    private String name;

    StateStatus(String name) {
        this.name = name;
    }

    @Override
    public String getName() {
        return name;
    }
}
