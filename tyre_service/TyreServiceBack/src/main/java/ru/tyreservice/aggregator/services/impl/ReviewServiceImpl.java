package ru.tyreservice.aggregator.services.impl;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.tyreservice.aggregator.dto.requests.ReviewDTO;
import ru.tyreservice.aggregator.entities.Partner;
import ru.tyreservice.aggregator.entities.Review;
import ru.tyreservice.aggregator.services.PartnerService;
import ru.tyreservice.aggregator.services.ReviewService;

import java.util.Date;

@AllArgsConstructor
@Service
public class ReviewServiceImpl implements ReviewService {
    private final PartnerService partnerService;

    @Override
    @Transactional
    public void createReview(Long partnerId, ReviewDTO review) {
        Partner partner = partnerService.findById(partnerId);
        partner.getReviews().add(ReviewDTO.toEntity(review));
        int countBall = partner.getReviews().size();
        int sumBall = partner.getReviews().stream().mapToInt(Review::getBall).reduce(0, Integer::sum);
        partner.setRank((int)(10.0*sumBall/countBall)/10.0);
    }
}
