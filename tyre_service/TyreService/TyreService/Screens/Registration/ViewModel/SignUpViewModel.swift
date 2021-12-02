//
//  SignUpViewModel.swift
//  TyreService
//
//  Created by Kirill Severin on 6.10.21.
//

import Foundation

class SignUpViewModel {
    
    private var authManager: AuthManager!
    public var showErrorMessage: ((String) -> ())?
    public var dismissController: (() -> ())?
    public var registrationFailed: ((String) -> ())?
    
    required init() {
        authManager = AuthManager()
    }
    
    //MARK: - Registration
    
    func registration(name: String, phone: String, email: String, password: String) {
        
        let name = name.trimmingCharacters(in: .whitespaces)
        let phone = phone.trimmingCharacters(in: .whitespaces).filter("0123456789".contains)
        let email = email.trimmingCharacters(in: .whitespaces)
        let password = password.trimmingCharacters(in: .whitespaces)
        
        if name.count < 2 {
            self.showErrorMessage?(NSLocalizedString(Errors.emptyName, comment: ""))
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
        if password.count < 6 {
            self.showErrorMessage?(NSLocalizedString(Errors.smallPassword, comment: ""))
            return
        }
        let partner = Partner(name: name, phone: phone, email: email, password: password)
        authManager.createPartner(parter: partner) { [weak self] (status, error) in
            if status == .ok {
                self?.dismissController?()
            } else {
                self?.registrationFailed?(error ?? NSLocalizedString(Errors.registrationFailed, comment: ""))
            }
        }
    }
    
    //MARK: - CheckValidFeilds
    
    func checkPasswordStrength(password: String) -> Int {
        var strengthPassword = 0
        
        let passwordWithBigCh = NSPredicate(format: "SELF MATCHES %@ ",
                                            "^(?=.*[a-z])(?=.*[A-Z]).{6,}$")
        let passwordWithDigit = NSPredicate(format: "SELF MATCHES %@ ",
                                            "^(?=.*[a-z])(?=.*[0-9]).{6,}$")
        let passwordWithSpecialChar = NSPredicate(format: "SELF MATCHES %@ ",
                                                  "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        let passwordWithBigChAndDigit = NSPredicate(format: "SELF MATCHES %@ ",
                                                    "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}$")
        let passwordWithBigChAndSpecialCh = NSPredicate(format: "SELF MATCHES %@ ",
                                                        "^(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$#!%*?&]).{8,}$")
        let passwordWithDigitAndSpecialCh = NSPredicate(format: "SELF MATCHES %@ ",
                                                        "^(?=.*[a-z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{8,}$")
        let hardestPassword = NSPredicate(format: "SELF MATCHES %@ ",
                                          "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{10,}$")
        
        switch password {
        case _ where hardestPassword.evaluate(with: password) :
            strengthPassword = 1
        case _ where passwordWithBigChAndDigit.evaluate(with: password) || passwordWithBigChAndSpecialCh.evaluate(with: password) || passwordWithDigitAndSpecialCh.evaluate(with: password) :
            strengthPassword = 2
        case _ where passwordWithDigit.evaluate(with: password) || passwordWithBigCh.evaluate(with: password) || passwordWithSpecialChar.evaluate(with: password) :
            strengthPassword = 3
        case _ where password.count >= 6 :
            strengthPassword = 4
        default:
            strengthPassword = 0
        }
        return strengthPassword
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
