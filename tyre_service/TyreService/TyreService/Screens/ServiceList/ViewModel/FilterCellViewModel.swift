//
//  GroupCellViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 4.10.21.
//

import Foundation

class CarTypeCellViewModel {
    let key: String
    let name: String
    var isSelected: Bool
    
    required init(key: String, name: String, isSelected: Bool) {
        self.key = key
        self.name = name
        self.isSelected = isSelected
    }
}
