//
//  RegistrationWorksViewController.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 21.10.21.
//

import UIKit

class RequestWorksViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var carInfo: UITextField!
    @IBOutlet weak var visitDate: UIDatePicker!
    @IBOutlet weak var buttonCreateRequestOnWorks: UIButton!
    @IBOutlet weak var tableWorks: UITableView!
    
    weak var viewModel: RequestWorksViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        hideKeyboardWhenTappedAround(changeViewSize: false)
    }
    
    private func initView() {
        buttonCreateRequestOnWorks.layer.cornerRadius = 8
        buttonCreateRequestOnWorks.layer.borderWidth = 1
        buttonCreateRequestOnWorks.layer.borderColor = UIColor(named: "buttonBorderColor")?.cgColor
        
        tableWorks.register(RequestWorksTableViewCell.nib(), forCellReuseIdentifier: RequestWorksTableViewCell.cellIdentifier)
        
        viewModel?.showMessage = { [weak self] (message) in
            self?.showErrorAlert(with: "Ошибка", and: message)
        }
        
        viewModel?.success = { [weak self] in
            self?.showErrorAlert(with: "", and: "Запись успешно добавлена", handler: {
                self?.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func actionCreateRequestOnWorks(_ sender: Any) {
        viewModel?.sendRequestOnWorks(name: name.text ?? "", phone: phoneNumber.text ?? "", auto: carInfo.text ?? "", visitDate: visitDate.date)
    }
    
    @IBAction func changePhoneNumber(_ sender: Any) {
        guard let text = phoneNumber.text else { return }
        phoneNumber.text = text.applyPatternOnNumbers(pattern: "+# (###) ###-####", replacementCharacter: "#")
    }
}

extension RequestWorksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberWorks() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RequestWorksTableViewCell.cellIdentifier, for: indexPath) as! RequestWorksTableViewCell
        if let viewModel = viewModel {
            cell.configure(viewModel: viewModel.getWorkCellViewModel(index: indexPath.row))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
