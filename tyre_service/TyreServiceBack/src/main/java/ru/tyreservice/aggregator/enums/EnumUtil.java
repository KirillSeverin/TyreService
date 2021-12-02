package ru.tyreservice.aggregator.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class EnumUtil {


    public static List<KeyValue> getListKeyValue(Nameable ... enums) {
        return Arrays.stream(enums).map(e -> new KeyValue(e.toString(), e.getName())).collect(Collectors.toList());
    }

    @AllArgsConstructor
    @Getter
    public static class KeyValue {
        private String key;
        private String name;
    }
}
