//
//  PartnerInfoViewModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 12.10.21.
//

import Foundation

class ServiceInfoViewModel {
    private var service: Service?
    private var menuListCellViewModel: [MenuCellServiceInfoViewModel] = []
    private var contactsCellViewModel: ContactsCellViewModel
    private var aboutServiceCellViewModel: AboutCellViewModel
    private var reviewsCellViewModel: ReviewCellViewModel
    private var networkManager: NetworkManager
    private var registrationWorksViewModel: RequestWorksViewModel?
    private var createReviewViewModel: CreateReviewViewModel?
    private var selectedMenuItem: Int = 0 {
        didSet {
            menuListCellViewModel.forEach { menuItemViewModel in
                menuItemViewModel.isSelected = menuItemViewModel.id == selectedMenuItem
            }
            reloadMenu?()
        }
    }
    
    var showRegistrationWorks: (()->())?
    var showCreateReview: (()->())?
    var reloadMenu: (()->())?
    var reloadInfo: (()->())?
    var updateImageView: ((Data)->())?
    
    required init(service: Service) {
        self.service = service
        networkManager = NetworkManager()
        aboutServiceCellViewModel = AboutCellViewModel(viewModel: service, actionRegistrationWorks:  showRegistrationWorks ?? {})
        reviewsCellViewModel = ReviewCellViewModel(reviews: service.reviews ?? [], actionShowCreateReview: showCreateReview ?? {})
        contactsCellViewModel = ContactsCellViewModel(longitude: service.longitude,
                                                           latitude: service.latitude,
                                                           address: service.address,
                                                           workTime: service.schedule,
                                                           phone: service.phone)
        getFullInfoService()
        createMenu()
    }
    
    public func getFullInfoService() {
        guard let idService = service?.id else { return }
        networkManager.getFullInfoService(id: idService) { [weak self] (status, service) in
            switch status {
            case .ok:
                guard let service = service else { return }
                self?.service = service
                self?.aboutServiceCellViewModel = AboutCellViewModel(viewModel: service, actionRegistrationWorks: self?.showRegistrationWorks ?? {})
                self?.contactsCellViewModel = ContactsCellViewModel(longitude: service.longitude,
                                                                   latitude: service.latitude,
                                                                   address: service.address,
                                                                   workTime: service.schedule,
                                                                   phone: service.phone)
                self?.reviewsCellViewModel = ReviewCellViewModel(reviews: service.reviews ?? [], actionShowCreateReview: self?.showCreateReview ?? {})
                self?.reloadInfo?()
                break
            case .error:
                break
            }
        }
    }
    
    private func createMenu() {
        menuListCellViewModel.append(MenuCellServiceInfoViewModel(id: 0, title: "О сервисе", isSelected: true))
        menuListCellViewModel.append(MenuCellServiceInfoViewModel(id: 1, title: "Контакты", isSelected: false))
        menuListCellViewModel.append(MenuCellServiceInfoViewModel(id: 2, title: "Отзывы", isSelected: false))
    }

    public func getNumberMenuItems() -> Int {
        return menuListCellViewModel.count
    }
    
    public func getMenuItemViewModel(index: Int) -> MenuCellServiceInfoViewModel {
        return menuListCellViewModel[index]
    }
    
    public func changeSelectedMenuItem(index: Int) {
       selectedMenuItem = index
    }
    
    public func getAboutServiceCellViewModel() -> AboutCellViewModel {
        return aboutServiceCellViewModel
    }
    
    public func getContactsCellViewModel() -> ContactsCellViewModel {
        return contactsCellViewModel
    }
    
    public func getReviewsCellViewModel() -> ReviewCellViewModel {
        return reviewsCellViewModel
    }
    
    public func getServiceName() -> String {
        guard let service = service else {
            return ""
        }
        return service.name
    }
    
    public func getRegistrationWorksViewModel() -> RequestWorksViewModel? {
        if let service = service {
            registrationWorksViewModel = RequestWorksViewModel(service: service)
            return registrationWorksViewModel
        }
        
        return nil
    }
    
    public func getCreateReviewViewModel() -> CreateReviewViewModel? {
        if let service = service {
            createReviewViewModel = CreateReviewViewModel(serviceId: service.id)
            return createReviewViewModel
        }
        
        return nil
    }
    
    public func getImageUrl() -> URL? {
        if let imageName = service?.imageName {
            if let imagePath = imageName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                if let url = URL(string: "https://" + imagePath) {
                    return url
                }
            }
        }
        return nil
    }
}
