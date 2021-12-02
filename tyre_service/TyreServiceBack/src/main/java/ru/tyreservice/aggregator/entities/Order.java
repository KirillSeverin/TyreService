package ru.tyreservice.aggregator.entities;

import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.enums.StateStatus;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(nullable = false, name = "partner_id")
    private Partner partner;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false, name = "create_date")
    private Date createDate;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(nullable = false, name = "booking_date")
    private Date bookingDate;
    @Column(nullable = false)
    @Enumerated(value = EnumType.STRING)
    private StateStatus status;



    @Column(name = "client_id")
    private Long clientId;
    @Column(name = "client_name")
    private String clientName;
    @Column(nullable = false, name = "client_phone")
    private String clientPhone;
    @Column(name = "client_auto")
    private String clientAuto;

    @ElementCollection
    @CollectionTable(name = "lines_order",
            joinColumns = @JoinColumn(name = "order_id", nullable = false))
    Set<LineOrder> lines;
}
