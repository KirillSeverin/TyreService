package ru.tyreservice.aggregator.entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Embeddable;
import javax.persistence.ManyToOne;

@Embeddable
@Getter
@Setter
public class LineOrder {
    @ManyToOne
    private Work work;
    private int count;
    private int price;
}
