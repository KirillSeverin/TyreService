//
//  MenuServiceInfoViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 12.10.21.
//

import Foundation

class MenuCellServiceInfoViewModel {
    var id: Int
    var title: String
    var isSelected: Bool
    
    required init(id: Int, title: String, isSelected: Bool) {
        self.id = id
        self.title = title
        self.isSelected = isSelected
    }
}
