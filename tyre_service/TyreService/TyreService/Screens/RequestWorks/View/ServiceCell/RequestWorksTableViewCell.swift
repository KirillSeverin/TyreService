//
//  RequestWorksTableViewCell.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 21.10.21.
//

import UIKit

class RequestWorksTableViewCell: UITableViewCell {

    @IBOutlet weak var workTitle: UILabel!
    @IBOutlet weak var workSwitch: UISwitch!
    
    static let cellIdentifier = "RequestWorksTableViewCell"
    
    weak var viewModel: RequestWorkCellViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    
    public func configure(viewModel: RequestWorkCellViewModel) {
        self.viewModel = viewModel
        workTitle.text = viewModel.name
    }
    
    @IBAction func changeStatusSwitch(_ sender: Any) {
        if let viewModel = viewModel {
            viewModel.changeStatusActive(isActive: workSwitch.isOn)
        }
    }
}
