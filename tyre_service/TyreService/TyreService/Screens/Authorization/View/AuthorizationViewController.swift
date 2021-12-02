//
//  AuthorizationViewController.swift
//  TyreService
//
//  Created by Kirill Severin on 10.10.21.
//

import UIKit
import SideMenu

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    var viewModel: AuthorizationViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func passwordTextField(_ sender: UITextField) {
        viewModel.checkEmptyPassword(password: passwordTF.text ?? "") ? signInButtonTrue() : signInButtonFalse()
    }
    
    @IBAction func showSideMenu(_ sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SideMenu", bundle:nil)
        let menu = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuNavigationController
        menu.settings = createSettingsSideMenu()
        SideMenuManager.default.leftMenuNavigationController = menu
        if let navController = navigationController {
            SideMenuManager.default.addPanGestureToPresent(toView: navController.navigationBar)
            SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: navController.view)
        }
        present(menu, animated: true, completion: nil)
    }
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        viewModel.authorization(email: emailTF.text ?? "", password: passwordTF.text ?? "")
    }
    
    private func setupUI() {
        setUpViewModel()
        signInButton.isEnabled = false
        navigationController?.setNavigationBarHidden(false, animated: false)
        hideKeyboardWhenTappedAround()
    }
    
    private func signInButtonTrue() {
        signInButton.isEnabled = true
    }
    
    private func signInButtonFalse() {
        signInButton.isEnabled = false
    }
    
    private func setUpViewModel() {
        viewModel = AuthorizationViewModel()
        viewModel.showErrorMessage = { [weak self] errorMessage in
            self?.showErrorAlert(and: errorMessage)
        }
        viewModel.success = { [weak self] in
            let storyBoard = UIStoryboard(name: "PartnerCabinet", bundle: nil)
            let partnerCabinet = storyBoard.instantiateViewController(withIdentifier: "PartnerCabinetVC") as! PartnerCabinetViewController
            self?.navigationController?.pushViewController(partnerCabinet, animated: true)
        }
    }
    
    private func createSettingsSideMenu() -> SideMenuSettings {
        var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.statusBarEndAlpha = 0
        settings.menuWidth = min(UIScreen.main.bounds.width - 50, 500);
        return settings
    }
    
}
