package ru.tyreservice.aggregator.entities;

import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.enums.StateCarType;

import javax.persistence.*;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "partners")
public class Partner {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = false)
    private String name;
    private String description;
    private String address;
    @Column(nullable = false)
    private String email;
    @Column(nullable = false)
    private String phone;
    private String schedule;
    private Double rank;
    private Double latitude;
    private Double longitude;
    @Column(nullable = false, name = "type")
    @Enumerated(value = EnumType.STRING)
    private StateCarType carType;
    @OneToMany(mappedBy = "partner", cascade = CascadeType.ALL)
    private Set<CostWork> costsWorks = new HashSet<>();
    @Column(name = "image")
    private String imageName;
    @ElementCollection
    @CollectionTable(name = "reviews", joinColumns = @JoinColumn(name = "partner_id", nullable = false))
    List<Review> reviews;
}
