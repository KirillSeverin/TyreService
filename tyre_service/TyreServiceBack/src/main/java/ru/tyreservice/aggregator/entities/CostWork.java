package ru.tyreservice.aggregator.entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Entity
@Table(name = "costs_works")
public class CostWork {
    @EmbeddedId
    private Id id = new Id();
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "partner_id", nullable = false, insertable = false, updatable = false)
    private Partner partner;
    @ManyToOne
    @JoinColumn(name = "work_id", nullable = false, insertable = false, updatable = false)
    private Work work;
    private Long price;

    public CostWork(Partner partner, Work work, Long price) {
        this.id.partnerId = partner.getId();
        this.id.workId = work.getId();
        this.partner = partner;
        this.work = work;
        this.price = price;
    }

    public CostWork() {
    }

    @Getter@Setter
    @Embeddable
    public static class Id implements Serializable{
        @Column(name = "partner_id")
        private Long partnerId;
        @Column(name = "work_id")
        private Long workId;

        public Id(Long partnerId, Long workId) {
            this.partnerId = partnerId;
            this.workId = workId;
        }

        public Id() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Id id = (Id) o;
            return partnerId.equals(id.partnerId) && workId.equals(id.workId);
        }

        @Override
        public int hashCode() {
            return Objects.hash(partnerId, workId);
        }
    }
}
