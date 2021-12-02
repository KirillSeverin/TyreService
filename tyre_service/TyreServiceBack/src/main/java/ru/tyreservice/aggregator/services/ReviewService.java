package ru.tyreservice.aggregator.services;

import ru.tyreservice.aggregator.dto.requests.ReviewDTO;

public interface ReviewService {
    void createReview(Long partnerId, ReviewDTO review);
}
