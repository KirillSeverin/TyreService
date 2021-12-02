//
//  Constants.swift
//  TyreService
//
//  Created by Kirill Severin on 21.10.21.
//

import Foundation

enum Constants {
    static let api = "http://194.67.91.182:8081/api"
    static let apiPartners = "\(api)/partners"
    static let apiRegistration = "\(api)/registration"
    static let apiAuthorization = "\(api)/login"
    static let apiPersonalCabinet = "\(api)/lk"
    static let apiServices = "\(api)/works"
    static let apiUpdatingServices = "\(api)/lk/works"
    static let apiSavePersonalInfoPartner = "\(api)/lk"
    static let apiUploadPartnerPhoto = "\(api)/lk/images"
    static let apiCreateOrder = "\(api)/orders"
    static let apiOrders = "\(api)/lk/orders"
}
