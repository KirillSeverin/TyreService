//
//  PartnerModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 4.10.21.
//

import Foundation

struct ServiceInitData: Decodable {
    let types: [CarType]
    let works: [TypeService]
    let partners: [Service]
}

struct CarType: Decodable, Equatable {
    let key: String
    let name: String
}

struct TypeService: Decodable, Equatable {
    let id: Int
    let name: String
    let price: Int?
    let description: String?
}

struct Service: Decodable {
    let id: Int
    let name: String
    let description: String?
    let email: String
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let schedule: String?
    let phone: String
    let rank: Double?
    let carType: String
    let imageName: String?
    let works: [TypeService]?
    let reviews: [Review]?
}

struct Review: Decodable {
    let ball: Int
    let message: String
    let name: String
    let date: String
}
