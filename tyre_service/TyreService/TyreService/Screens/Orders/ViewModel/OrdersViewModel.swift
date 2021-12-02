//
//  OrdersViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 24.10.21.
//

import Foundation

class OrdersViewModel {
    private let networkManager = NetworkManager()
    private var ordersCellViewModel: [OrderCellViewModel] = []
    
    public var errorMessage: ((String) -> ())?
    public var reloadData: (() -> ())?

    required init() {
       getOrders()
    }
    
    private func getOrders() {
        networkManager.getOrders { [weak self] (status, orders) in
            switch status {
            case .ok:
                if let orders = orders {
                    self?.initOrdersCellViewModel(orders: orders)
                    self?.reloadData?()
                }
            case .error:
                self?.errorMessage?(Errors.errorLoadData)
            }
        }
    }
    
    private func initOrdersCellViewModel(orders: [Order]) {
        orders.forEach { order in
            ordersCellViewModel.append(OrderCellViewModel(order: order))
        }
    }
    
    public func getNumberOfOrders() -> Int {
        return ordersCellViewModel.count
    }
    
    public func getOrderCellViewModel(index: Int) -> OrderCellViewModel {
        return ordersCellViewModel[index]
    }
    
    public func updateOrders() {
        ordersCellViewModel = []
        getOrders()
    }
}
