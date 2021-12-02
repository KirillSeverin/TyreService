//
//  PartnerServiceCellViewModel.swift
//  TyreService
//
//  Created by Kirill Severin on 15.10.21.
//

import Foundation

class PartnerServiceCellViewModel {
    
    var id: Int
    let name: String
    var price: Int
    var isActive: Bool
    
    required init(id: Int, name: String, price: Int, isActive: Bool) {
        self.id = id
        self.name = name
        self.price = price
        self.isActive = isActive
    }
    
    
    
}
