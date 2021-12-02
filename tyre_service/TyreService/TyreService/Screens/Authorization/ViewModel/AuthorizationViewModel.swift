//
//  AuthorizationViewModel.swift
//  TyreService
//
//  Created by Kirill Severin on 10.10.21.
//

import Foundation

class AuthorizationViewModel {
    
    var showErrorMessage: ((String) -> ())?
    var authManager: AuthManager = AuthManager()
    var success: (() -> ())?
    
    func checkEmptyPassword(password: String) -> Bool {
        if password.count <= 5 {
            return false
        } else {
            return true
        }
    }
    
    func authorization(email: String, password: String) {
        let email = email.trimmingCharacters(in: .whitespaces)
        let password = password.trimmingCharacters(in: .whitespaces)
        
        if !isValidEmail(email) {
            self.showErrorMessage?(NSLocalizedString(Errors.emptyOrIncorrectEmail, comment: ""))
            return
        }
        if password == "" {
            self.showErrorMessage?(NSLocalizedString(Errors.smallPassword, comment: ""))
            return
        }
        
        authManager.authorizationPartner(email: email, password: password) { [weak self] (status, token) in
            if status == .ok {
                if let token = token {
                    UserDefaults.standard.set(token, forKey: "token")
                }
                self?.success?()
            } else {
                self?.showErrorMessage?(NSLocalizedString(Errors.authorizationError, comment: ""))
            }
        }
        
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
