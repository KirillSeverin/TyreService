//
//  MenuServiceInfoCollectionViewCell.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 12.10.21.
//

import UIKit

class MenuServiceInfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    static let cellIdentifier = "MenuServiceInfoCollectionViewCell"

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
    
    public func configure(viewModel: MenuCellServiceInfoViewModel) {
        self.title.text = viewModel.title
        if viewModel.isSelected {
            self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.3)
        } else {
            self.backgroundColor = .clear
        }
    }
}
