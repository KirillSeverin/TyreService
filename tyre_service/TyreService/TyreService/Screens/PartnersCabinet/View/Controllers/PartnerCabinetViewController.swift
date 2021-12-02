//
//  PartnerCabinetViewController.swift
//  TyreService
//
//  Created by Kirill Severin on 12.10.21.
//

import UIKit
import SideMenu
import RSSelectionMenu
import CoreLocation
import Kingfisher

class PartnerCabinetViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    @IBOutlet weak var latitudeTF: UITextField!
    @IBOutlet weak var longitudeTF: UITextField!
    @IBOutlet weak var carTypeBtn: UIButton!
    private var viewModel: PartnerCabinetViewModel!
    private let imagePicker = UIImagePickerController()
    private let location = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK: Actions
    
    @IBAction func updatePhoto(_ sender: UIButton) {
        showAlertOfActionSelection()
    }
    
    @IBAction func chooseTypeOfCar(_ sender: UIButton) {
        let selectionMenu = RSSelectionMenu(selectionStyle: .single, dataSource: viewModel.getTypeOfCar()) { (cell, carType, indexPath) in
            cell.textLabel?.text = carType.name
        }
        selectionMenu.onDismiss = { [weak self] selectedItem in
            if let carType = selectedItem.first {
                self?.viewModel.updateCarType(carType: carType.key)
                self?.carTypeBtn.setTitle(carType.name, for: .normal)
            }
        }
        if let selectedType = viewModel.getSelectedCarTypeObject() {
            selectionMenu.setSelectedItems(items: [selectedType]) { (text, index, isSelected, selectedItems) in }
        }
        selectionMenu.cellSelectionStyle = .checkbox
        selectionMenu.show(style: .actionSheet(title: "Тип авто", action: "Применить", height: nil), from: self)
    }
    
    
    @IBAction func showLServicesList(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "PartnerCabinet", bundle: nil)
        let partnerServicesVC = storyBoard.instantiateViewController(withIdentifier: "PartnerServicesTableVC") as! PartnerServicesTableViewController
        partnerServicesVC.viewModel = viewModel.getPartnerServicesViewModel()
        navigationController?.pushViewController(partnerServicesVC, animated: true)
        
    }
    
    @IBAction func saveCreatedInformation(_ sender: UIBarButtonItem) {
        viewModel.saveCredentials(name: nameTF.text ?? "", description: descriptionTextView.text ?? "", phone: phoneTF.text ?? "", email: emailTF.text ?? "", address: addressTF.text ?? "", workingHours: workingHours.text ?? "", lon: longitudeTF.text ?? "", lat: latitudeTF.text ?? "")
    }
    
    @IBAction func showLeftMenu(_ sender: UIBarButtonItem) {
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
    
    @IBAction func defineCurrentLocation(_ sender: Any) {
        latitudeTF.text = 53.894828.description
        longitudeTF.text = 27.533744.description
    }
    
    @IBAction func changePhoneNumber(_ sender: Any) {
        guard let text = phoneTF.text else { return }
        phoneTF.text = text.applyPatternOnNumbers(pattern: "+# (###) ###-####", replacementCharacter: "#")
    }
    
    //MARK: - SetUpView
    
    private func initViewModel() {
        viewModel = PartnerCabinetViewModel()
        viewModel.showErrorMessage = { [weak self] errorMassage in
            self?.showErrorAlert(and: errorMassage)
        }
        viewModel.updateInfo = { [weak self] in
            self?.nameTF.text = self?.viewModel.service.lk.name
            self?.descriptionTextView.text = self?.viewModel.service.lk.description
            self?.phoneTF.text = self?.viewModel.service.lk.phone.applyPatternOnNumbers(pattern: "+# (###) ###-####", replacementCharacter: "#")
            self?.emailTF.text = self?.viewModel.service.lk.email
            self?.addressTF.text = self?.viewModel.service.lk.address
            self?.workingHours.text = self?.viewModel.service.lk.schedule
            self?.latitudeTF.text = self?.viewModel.service.lk.latitude?.description
            self?.longitudeTF.text = self?.viewModel.service.lk.longitude?.description
            if let image = self?.viewModel.service.lk.imageName {
                if let imagePath = image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    if let url = URL(string: "https://" + imagePath) {
                        self?.photo.kf.setImage(with: url)
                    }
                }
            }
            if let selectedType = self?.viewModel.getSelectedCarTypeObject() {
                self?.carTypeBtn.setTitle(selectedType.name, for: .normal)
            }
        }
        
        viewModel.dataSuccessfullySaved = { [weak self] errorMessage in
            self?.showErrorAlert(with: "", and: errorMessage)
        }
        viewModel.noDataSaved = { [weak self] errorMessage in
            self?.showErrorAlert(and: errorMessage)
        }
    }
    
    private func createSettingsSideMenu() -> SideMenuSettings {
        var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.statusBarEndAlpha = 0
        settings.menuWidth = min(UIScreen.main.bounds.width - 50, 500);
        return settings
    }
    
    private func setUpUI() {
        initViewModel()
        self.hideKeyboardWhenTappedAround()
        imagePicker.delegate = self
        descriptionTextView.layer.cornerRadius = 5
        navigationController?.setNavigationBarHidden(false, animated: false)
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.requestAlwaysAuthorization()
    }
    
    //MARK: - AlertOfActionSelection
    
    private func showAlertOfActionSelection() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Камера", style: .default, handler: { [weak self] _ in
            self?.openCamera()
        })
        let galleryAction = UIAlertAction(title: "Галарея", style: .default, handler: { [weak self] _ in
            self?.openGallery()
        })
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    private func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            showErrorAlert(with: "Ошибка", and: "У вас нет камеры")
        }
    }

    private func openGallery() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}

    //MARK: - Extension

extension PartnerCabinetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("\(info)")
        }
        photo.image = selectedImage
        if let imgData = selectedImage.jpegData(compressionQuality: 0.3) {
            viewModel.uploadPhoto(imageData: imgData)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension PartnerCabinetViewController: UIScrollViewDelegate {
        
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        } else {
            UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                
            }, completion: nil)
        }
    }
}
