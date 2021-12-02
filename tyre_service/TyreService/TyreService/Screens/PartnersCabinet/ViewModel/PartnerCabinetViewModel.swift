//
//  PartnerCabinetViewModel.swift
//  TyreService
//
//  Created by Kirill Severin on 15.10.21.
//

import Foundation

class PartnerCabinetViewModel {
    
    private var networkManager: NetworkManager
    private var partnerServicesViewModel: PartnerServicesViewModel?
    private var selectedCarType: String?
    var service: PersonalArea!
    public var updateInfo: (() -> ())?
    public var noDataSaved: ((String) -> ())?
    public var dataSuccessfullySaved: ((String) -> ())?
    public var showErrorMessage: ((String) -> ())?
    
    required init() {
       networkManager = NetworkManager()
       getServiceInfo()
   }
    
    func getServiceInfo() {
        networkManager.getInfoForPartnerCabinet { [weak self] (requestStatus, service) in
            switch requestStatus {
            case .ok:
                if let service = service {
                    self?.selectedCarType = service.lk.carType
                    self?.service = service
                    self?.updateInfo?()
                    self?.partnerServicesViewModel = PartnerServicesViewModel(partnerServices: service.lk.works ?? [])
                }
            case .error:
                break
            }
        }
    }
    
    func saveCredentials(name: String, description: String, phone: String, email: String, address: String, workingHours: String, lon: String, lat: String) {
        
        let name = name.trimmingCharacters(in: .whitespaces)
        let description = description.trimmingCharacters(in: .whitespaces)
        let phone = phone.trimmingCharacters(in: .whitespaces).filter("0123456789".contains)
        let email = email.trimmingCharacters(in: .whitespaces)
        let address = address.trimmingCharacters(in: .whitespaces)
        let workingHours = workingHours.trimmingCharacters(in: .whitespaces)
        
        if name.count < 2 {
            self.showErrorMessage?(NSLocalizedString(Errors.emptyName, comment: ""))
            return
        }
        if description.count < 25 {
            self.showErrorMessage?(NSLocalizedString(Errors.emptyField, comment: ""))
            return
        }
        if phone.count < 11 {
            self.showErrorMessage?(NSLocalizedString(Errors.emptyOrIncorrectPhone, comment: ""))
            return
        }
        if !isValidEmail(email) {
            self.showErrorMessage?(NSLocalizedString(Errors.emptyOrIncorrectEmail, comment: ""))
            return
        }
        if address.count < 18 {
            self.showErrorMessage?(NSLocalizedString(Errors.emptyOrIncorrectAddress, comment:  ""))
            return
        }
        if workingHours.count < 10 {
            self.showErrorMessage?(NSLocalizedString(Errors.emptyWorkingHours, comment: ""))
            return
        }
        if lon == "" && lat == "" {
            self.showErrorMessage?(NSLocalizedString(Errors.emptyCoordinates, comment: ""))
            return
        }
        
        let lonToDouble: Double = Double(lon.description ) ?? 0.0
        let latToDouble: Double = Double(lat.description ) ?? 0.0
        
        networkManager.savePersonalInfoPartner(id: service.lk.id,
                                               name: name,
                                               description: description,
                                               email: email,
                                               phone: phone,
                                               address: address,
                                               schedule: workingHours,
                                               longitude: lonToDouble,
                                               latitude: latToDouble,
                                               carType: selectedCarType ?? "") { [weak self] response in
            switch response {
            case .ok:
                self?.dataSuccessfullySaved?(NSLocalizedString(Errors.dataSuccessfullySaved, comment: ""))
            case .error:
                self?.noDataSaved?(NSLocalizedString(Errors.noDataSaved, comment: ""))
            }
        }
        
    }
    
    public func getTypeOfCar() -> [CarType] {
        return service.types
    }
    
    public func getKeyForTypeOfCar(object: CarType) -> String {
        return object.key
    }
    
    public func getPartnerServicesViewModel() -> PartnerServicesViewModel? {
        return partnerServicesViewModel
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    public func updateCarType(carType: String) {
        selectedCarType = carType
    }
    
    public func getSelectedCarTypeObject() -> CarType? {
        for type in service.types {
            if selectedCarType == type.key {
                return type
            }
        }
        
        return nil
    }
    
    public func uploadPhoto(imageData: Data) {
        networkManager.uploadPartnerPhoto(data: imageData) { [weak self] status in
            switch status {
            case .ok:
                self?.dataSuccessfullySaved?(NSLocalizedString(Errors.imageSuccessSave, comment: ""))
            case .error:
                self?.noDataSaved?(NSLocalizedString(Errors.imageErrorSave, comment: ""))
            }
        }
    }
}
