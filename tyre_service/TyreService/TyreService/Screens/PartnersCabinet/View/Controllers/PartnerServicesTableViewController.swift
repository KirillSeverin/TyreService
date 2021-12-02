//
//  PartnerServicesTableViewController.swift
//  TyreService
//
//  Created by Kirill Severin on 17.10.21.
//

import UIKit

class PartnerServicesTableViewController: UITableViewController {
    
    weak var viewModel: PartnerServicesViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    @IBAction func saveListOfServices(_ sender: UIBarButtonItem) {
          viewModel?.savePartnerServices()
    }
    
    private func initTableView() {
        tableView.register(PartnerServiceTableViewCell.nib(), forCellReuseIdentifier: PartnerServiceTableViewCell.cellIdentifier)
        viewModel?.updateInfo = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel?.updateInfoAndDismissScreen = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfPartnerCell() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PartnerServiceTableViewCell.cellIdentifier, for: indexPath) as! PartnerServiceTableViewCell
        if let viewModel = viewModel {
            cell.configure(viewModel: viewModel.getPartnerCellViewModel(index: indexPath.row))
        }
        return cell
    }

}
