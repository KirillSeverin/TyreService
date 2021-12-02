package ru.tyreservice.aggregator.dto.requests;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import ru.tyreservice.aggregator.entities.Review;

import java.time.LocalDateTime;
import java.util.Date;

@Getter@Setter
@Schema(description = "Отзыв")
public class ReviewDTO {
    @Schema(description = "Оценка")
    private Integer ball;
    @Schema(description = "Сообщение")
    private String message;
    @Schema(description = "Имя клиента")
    private String name;

    public static Review toEntity(ReviewDTO reviewDTO) {
        Review review = new Review();
        review.setBall(reviewDTO.getBall());
        review.setMessage(reviewDTO.getMessage());
        review.setName(reviewDTO.getName());
        review.setDate(new Date());
        return review;
    }
}
