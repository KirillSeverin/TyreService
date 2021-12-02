//
//  Order.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 24.10.21.
//

import Foundation

struct Order: Decodable {
    let id: Int
    let createDate: String
    let bookingDate: String
    let status: String
    let clientName: String
    let clientPhone: String
    let auto: String
    let fullPrice: Int
    let lines: [OrderWork]
}

struct OrderWork: Decodable {
    let name: String
    let price: Int
}
