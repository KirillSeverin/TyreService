//
//  PartnerCellViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 4.10.21.
//

import Foundation
import CoreLocation

class ServiceCellViewModel {
    var service: Service
    var distance: Double?
    
    required init(service: Service, lat: Double?, lon: Double?) {
        self.service = service
        if let lat = lat, let lon = lon {
            let coordinateOne = CLLocation(latitude: lat, longitude: lon)
            let coordinateTwo = CLLocation(latitude: service.latitude ?? 0.0, longitude: service.longitude ?? 0.0)
            distance = coordinateOne.distance(from: coordinateTwo) / 1000
        }
    }
}
