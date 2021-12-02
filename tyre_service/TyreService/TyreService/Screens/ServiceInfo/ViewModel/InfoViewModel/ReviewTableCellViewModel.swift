//
//  ReviewTableCellViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 23.10.21.
//

import Foundation

class ReviewTableCellViewModel {
    
    let review: Review
    
    required init(review: Review) {
        self.review = review
    }
    
    public func getDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "ru")
        guard let showDate = inputFormatter.date(from: review.date) else { return "" }
        inputFormatter.dateFormat = "d MMM HH:mm"
        return inputFormatter.string(from: showDate)
    }
}
