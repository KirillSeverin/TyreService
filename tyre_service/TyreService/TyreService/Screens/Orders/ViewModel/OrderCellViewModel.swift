//
//  OrderCellViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 24.10.21.
//

import Foundation

class OrderCellViewModel {
    private let order: Order
    
    required init (order: Order) {
        self.order = order
    }
    
    public func getUserInfo() -> String {
        return order.clientName + " (\(order.auto))"
    }
    
    public func getPhone() -> String {
        return order.clientPhone.applyPatternOnNumbers(pattern: "+# (###) ###-####", replacementCharacter: "#")
    }
    
    public func getDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "ru")
        guard let showDate = inputFormatter.date(from: order.bookingDate) else { return "30 окт." }
        inputFormatter.dateFormat = "d MMM"
        return inputFormatter.string(from: showDate)
    }
    
    public func getTime() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "ru")
        guard let showDate = inputFormatter.date(from: order.bookingDate) else { return "17:00" }
        inputFormatter.dateFormat = "HH:mm"
        return inputFormatter.string(from: showDate)
    }
    
    public func getWorksInfo() -> String {
        var works: [String] = []
        order.lines.forEach { work in
            works.append("- \(work.name) (\(work.price) руб.)")
        }
        return works.joined(separator:"\n")
    }
    
    public func getTotalPrice() -> String {
        return order.fullPrice.description + " руб."
    }
}
