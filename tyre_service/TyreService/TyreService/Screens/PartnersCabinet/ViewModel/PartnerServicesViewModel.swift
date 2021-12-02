//
//  PartnerServicesViewModel.swift
//  TyreService
//
//  Created by Kirill Severin on 23.10.21.
//

import Foundation

class PartnerServicesViewModel {
    
    private var networkManager: NetworkManager = NetworkManager()
    private var partnerServices: [TypeService]
    private var servicesViewModel: [PartnerServiceCellViewModel] = []
    public var updateInfo:(() -> ())?
    public var showErrorMessage: ((String) -> ())?
    public var updateInfoAndDismissScreen: (() -> ())?
    public var failedToLoadListOfServices: ((String) -> ())?
    
    
    required init(partnerServices: [TypeService]) {
        self.partnerServices = partnerServices
        getFullServices()
    }
    
    func getFullServices() {
        networkManager.getFullServicesList { [weak self] requestStatus, typeServices in
            switch requestStatus {
            case .ok:
                if let services = typeServices {
                    self?.initPartnerServicesCellViewModel(services: services)
                }
            case .error:
                self?.failedToLoadListOfServices?(NSLocalizedString(Errors.failedToLoadListOfServices, comment: ""))
            }
        }
    }
    
    func savePartnerServices() {
        
        let activeServices = servicesViewModel.filter { serviceCellViewModel in
            return serviceCellViewModel.isActive
        }.map { serviceCellViewModel in
            return TypeService(id: serviceCellViewModel.id, name: serviceCellViewModel.name, price: serviceCellViewModel.price, description: nil)
        }
        
        networkManager.saveServicesList(typeServices: activeServices) { [weak self] status in
            switch status {
            case .ok:
                self?.updateInfoAndDismissScreen?()
            case .error:
                self?.showErrorMessage?(NSLocalizedString(Errors.noDataSaved, comment: ""))
            }
        }
    }
    
    func initPartnerServicesCellViewModel(services: [TypeService]) {
        services.forEach { service in
            servicesViewModel.append(initPartnerServiceCellViewModel(typeService: service))
        }
    }
    
    func initPartnerServiceCellViewModel(typeService: TypeService) -> PartnerServiceCellViewModel {
        for partnerService in partnerServices {
            if typeService.id == partnerService.id {
                return PartnerServiceCellViewModel(id: typeService.id, name: typeService.name, price: partnerService.price ?? 0, isActive: true)
            }
        }
        return PartnerServiceCellViewModel(id: typeService.id, name: typeService.name, price: 0, isActive: false)
    }
    
    func getNumberOfPartnerCell() -> Int {
        return servicesViewModel.count
    }
    
    func getPartnerCellViewModel(index: Int) -> PartnerServiceCellViewModel {
        return servicesViewModel[index]
    }
}
