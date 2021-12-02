//
//  RegistrationWorksViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 21.10.21.
//

import Foundation

class RequestWorksViewModel {
    private var serviceInfo: Service
    private var networkManager = NetworkManager()
    private var requestWorkCellsViewModel: [RequestWorkCellViewModel] = []
    
    public var showMessage: ((String) -> ())?
    public var success: (() -> ())?

    init(service: Service) {
        serviceInfo = service
        initRequestWorkCellsViewModel(works: service.works ?? [])
    }
    
    private func initRequestWorkCellsViewModel(works: [TypeService]) {
        works.forEach { work in
            requestWorkCellsViewModel.append(RequestWorkCellViewModel(work: work))
        }
    }
    
    public func getNumberWorks() -> Int {
        return requestWorkCellsViewModel.count
    }
    
    public func getWorkCellViewModel(index: Int) -> RequestWorkCellViewModel {
        return requestWorkCellsViewModel[index]
    }
    
    public func sendRequestOnWorks(name: String, phone: String, auto: String, visitDate: Date) {
        let works = getSelectedWorks()
        if works.isEmpty {
            showMessage?("Выберите услугу(и)")
            return
        }
        
        if name == "" {
            showMessage?("Имя не может быть пустым")
            return
        }
        
        if phone == "" {
            showMessage?("Телефон не может быть пустым")
            return
        }
        
        if auto == "" {
            showMessage?("Заполните информацию об авто")
            return
        }
        
        networkManager.requestOnWorks(partnerId: serviceInfo.id,
                                      clientName: name,
                                      clientPhone: phone.filter("0123456789".contains),
                                      clientAuto: auto,
                                      works: works,
                                      visitDate: parseDate(date: visitDate),
                                      currentDate: parseDate(date: Date())) { [weak self] status in
            
            switch status {
            case .ok:
                self?.success?()
            case .error:
                break
            }
            
        }
    }
    
    private func getSelectedWorks() -> [TypeService] {
        var selectedWorks: [TypeService] = []
        requestWorkCellsViewModel.forEach { workVM in
            if workVM.isActive {
                selectedWorks.append(workVM.work)
            }
        }
        return selectedWorks
    }
    
    private func parseDate(date: Date) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormater.string(from: date)
    }
}
