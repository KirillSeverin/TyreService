//
//  RegistrationViewController.swift
//  TyreService
//
//  Created by Kirill Severin on 6.10.21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameOrganization: UITextField!
    @IBOutlet weak var phoneOrganization: UITextField!
    @IBOutlet weak var emailOrganization: UITextField!
    @IBOutlet weak var passwordOneTF: UITextField!
    
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var greenView: UIView!
    
    @IBOutlet weak var continueButton: UIButton!
    
    private var viewModel: SignUpViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        initViewModel()
        setUpStartColors()
    }
    
    //MARK: - Actions
    
    @IBAction func passwordOneTFChanged(_ sender: UITextField) {
        if let password = passwordOneTF.text {
            let levelPassword = viewModel.checkPasswordStrength(password: password)
            
            switch levelPassword {
            case 1 :
                redView.backgroundColor = .red
                orangeView.backgroundColor = .orange
                yellowView.backgroundColor = .yellow
                greenView.backgroundColor = .green
            case 2:
                redView.backgroundColor = .red
                orangeView.backgroundColor = .orange
                yellowView.backgroundColor = .yellow
                greenView.backgroundColor = .lightGray
            case 3:
                redView.backgroundColor = .red
                orangeView.backgroundColor = .orange
                yellowView.backgroundColor = .lightGray
                greenView.backgroundColor = .lightGray
            case 4:
                redView.backgroundColor = .red
                orangeView.backgroundColor = .lightGray
                yellowView.backgroundColor = .lightGray
                greenView.backgroundColor = .lightGray
            default:
                redView.backgroundColor = .lightGray
                orangeView.backgroundColor = .lightGray
                yellowView.backgroundColor = .lightGray
                greenView.backgroundColor = .lightGray
            }
        }
    }
    
    @IBAction func actionPhoneNumberChange(_ sender: Any) {
        guard let text = phoneOrganization.text else { return }
        phoneOrganization.text = text.applyPatternOnNumbers(pattern: "+# (###) ###-####", replacementCharacter: "#")
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        viewModel.registration(name: nameOrganization.text ?? "", phone: phoneOrganization.text ?? "", email: emailOrganization.text ?? "", password: passwordOneTF.text ?? "")
    }
    
    private func initViewModel() {
        viewModel = SignUpViewModel()
        viewModel.showErrorMessage =  { [weak self] errorMessage in
            self?.showErrorAlert(and: errorMessage)
        }
        viewModel.registrationFailed = { [weak self] (message) in
            self?.showErrorAlert(and:message)
        }
        viewModel.dismissController = { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setUpStartColors() {
        redView.backgroundColor = .lightGray
        orangeView.backgroundColor = .lightGray
        yellowView.backgroundColor = .lightGray
        greenView.backgroundColor = .lightGray
    }
    
}
