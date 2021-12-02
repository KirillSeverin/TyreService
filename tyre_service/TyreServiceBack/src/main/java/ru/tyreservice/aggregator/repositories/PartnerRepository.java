package ru.tyreservice.aggregator.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import ru.tyreservice.aggregator.entities.Partner;
import ru.tyreservice.aggregator.enums.StateCarType;

import java.util.List;

@Repository
public interface PartnerRepository extends JpaRepository<Partner, Long>, JpaSpecificationExecutor<Partner> {
    @Query(value = "select p from Partner p left join p.costsWorks cw where " +
            "(p.description is not null and p.address is not null and " +
            "(p.carType = :type or :type is null) and " +
            "(:name = '' or lower(p.name) like lower('%'||:name||'%')) and " +
            "(cw.work.id in :ids or (:ids) is null)) " +
            "group by p having count(p) >= :count " +
            "order by sqrt((p.latitude-:latitude)*(p.latitude-:latitude) + (p.longitude-:longitude)*(p.longitude-:longitude)) NULLS LAST,  p.rank desc NULLS LAST,  p.name")
    Page<Partner> findAllByFilter(Pageable pageable, StateCarType type, String name, List<Long> ids, Long count, Double latitude, Double longitude);
}
