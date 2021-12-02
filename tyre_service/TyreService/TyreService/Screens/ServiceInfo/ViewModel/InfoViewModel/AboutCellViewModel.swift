//
//  ServicesCellModel.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 13.10.21.
//

import Foundation

class AboutCellViewModel {
    private var actionRegistrationWorks: () -> Void
    var description: String
    var works: String = ""
    
    required init(viewModel: Service, actionRegistrationWorks: @escaping () -> Void = { }) {
        self.actionRegistrationWorks = actionRegistrationWorks
        description = viewModel.description ?? ""
        works = workToStrings(works: viewModel.works ?? [])
    }
    
    private func workToStrings(works: [TypeService]) -> String {
        var worksString = ""
        works.forEach { work in
            worksString += "- \(work.name) (\(work.price?.description ?? "") руб.) \n"
        }
        return worksString
    }
    
    public func showRegistrationWorksView() {
        actionRegistrationWorks()
    }
    
}
