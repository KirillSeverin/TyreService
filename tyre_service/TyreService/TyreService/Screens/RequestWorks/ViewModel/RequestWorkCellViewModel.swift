//
//  RequestWorksCellViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 21.10.21.
//

import Foundation

class RequestWorkCellViewModel {
    var work: TypeService
    var name: String
    var isActive: Bool = false

    init(work: TypeService) {
        self.work = work
        name = work.name
        if let price = work.price {
            name += " (\(price) руб.)"
        }
    }
    
    public func changeStatusActive(isActive: Bool) {
        self.isActive = isActive
    }
}
