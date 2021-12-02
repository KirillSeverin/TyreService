//
//  OrderTableViewCell.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 24.10.21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var worksInfo: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    static let cellIdentifier = "OrderTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(viewModel: OrderCellViewModel) {
        dateLabel.text = viewModel.getDate()
        timeLabel.text = viewModel.getTime()
        userInfoLabel.text = viewModel.getUserInfo()
        phoneLabel.text = viewModel.getPhone()
        worksInfo.text = viewModel.getWorksInfo()
        totalPrice.text = viewModel.getTotalPrice()
    }
}
