//
//  ServicesCollectionViewCell.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 12.10.21.
//

import UIKit

class AboutServiceCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier = "AboutServiceCollectionViewCell"
    @IBOutlet weak var buttonRegistrationService: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    
    weak var viewModel: AboutCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        initButtonRegistrationService()
    }
    
    func initButtonRegistrationService() {
        buttonRegistrationService.layer.cornerRadius = 8
        buttonRegistrationService.layer.borderWidth = 1
        buttonRegistrationService.layer.borderColor = UIColor(named: "buttonBorderColor")?.cgColor
    }
    
    static func nib() -> UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    
    public func configure(viewModel: AboutCellViewModel) {
        self.viewModel = viewModel
        descriptionLabel.text = viewModel.description
        servicesLabel.text = viewModel.works
    }

    @IBAction func actionRegistrationService(_ sender: Any) {
        if let viewModel = viewModel {
            viewModel.showRegistrationWorksView()
        }
    }
}
