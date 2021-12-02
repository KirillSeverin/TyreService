//
//  FilterCollectionViewCell.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 4.10.21.
//

import UIKit

class CarTypeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var text: UILabel!
    
    static let cellIdentifier = "CarTypeCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .clear
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
    
    static func nib() -> UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }
    
    public func configure(viewModel: CarTypeCellViewModel) {
        self.text.text = viewModel.name
        if viewModel.isSelected {
            self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3)
        } else {
            self.backgroundColor = .clear
        }
    }
}
