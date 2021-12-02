//
//  ContactsCellViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 13.10.21.
//

import Foundation

class ContactsCellViewModel {
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var workTime: String?
    var phone: String?
    
    required init(longitude: Double?, latitude: Double?, address: String?, workTime: String?, phone: String?) {
        self.longitude = longitude
        self.latitude = latitude
        self.address = address
        self.workTime = workTime
        self.phone = phone
    }
}
