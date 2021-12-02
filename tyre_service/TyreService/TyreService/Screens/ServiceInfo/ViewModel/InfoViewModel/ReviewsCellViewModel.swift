//
//  ReviesCellViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 13.10.21.
//

import Foundation

class ReviewCellViewModel {
    private var actionShowCreateReview: () -> Void
    private var reviewsTableCellViewModel: [ReviewTableCellViewModel] = []
    private let reviews: [Review]
    
    required init(reviews: [Review], actionShowCreateReview: @escaping () -> Void = { }) {
        self.reviews = reviews
        self.actionShowCreateReview = actionShowCreateReview
        initTableCellsViewModel()
    }
    
    private func initTableCellsViewModel() {
        reviews.forEach { review in
            reviewsTableCellViewModel.append(ReviewTableCellViewModel(review: review))
        }
    }
    
    public func getNumberReviews() -> Int {
        return reviewsTableCellViewModel.count
    }
    
    public func getTableCellViewModel(index: Int) -> ReviewTableCellViewModel {
        return reviewsTableCellViewModel[index]
    }
    
    public func showCreateReview() {
        actionShowCreateReview()
    }
}
