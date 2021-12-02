//
//  CreateReviewViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 24.10.21.
//

import Foundation

class CreateReviewViewModel {
    private let networkManager = NetworkManager()
    private let serviceId: Int
    private var selectedRating = 0
    
    public var showErrorMessage: ((String) -> ())?
    public var successAddReview: (() -> ())?
    
    required init(serviceId: Int) {
        self.serviceId = serviceId
    }
    
    public func updateRating(rating: Int) {
        selectedRating = rating
    }
    
    public func saveReview(name: String, description: String) {
        if name == "" {
            showErrorMessage?("Заполните Имя")
            return
        }
        
        if description == "" {
            showErrorMessage?("Оставьте отзыв")
            return
        }
        
        if selectedRating == 0 {
            showErrorMessage?("Поставьте оценку")
            return
        }
        
        networkManager.addReview(serviceId: serviceId, name: name, description: description, rating: selectedRating) { [weak self] status in
            switch status {
            case .ok:
                self?.successAddReview?()
            case .error:
                self?.showErrorMessage?("Ошибка добавление")
            }
        }
    }
}
