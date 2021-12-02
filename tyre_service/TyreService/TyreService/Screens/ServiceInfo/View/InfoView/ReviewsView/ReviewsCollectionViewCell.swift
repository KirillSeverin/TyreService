//
//  ReviewsCollectionViewCell.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 12.10.21.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tableReview: UITableView!
    @IBOutlet weak var buttonAddReview: UIButton!
    
    weak var viewModel: ReviewCellViewModel?

    static let cellIdentifier = "ReviewsCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        initButtonAddView()
        initTable()
    }
    
    func initButtonAddView() {
        buttonAddReview.layer.cornerRadius = 8
        buttonAddReview.layer.borderWidth = 1
        buttonAddReview.layer.borderColor = UIColor(named: "buttonBorderColor")?.cgColor
    }
    
    func initTable() {
        tableReview.register(ReviewTableViewCell.nib(), forCellReuseIdentifier: ReviewTableViewCell.cellIdentifier)
        tableReview.dataSource = self
    }
    
    static func nib() -> UINib {
        return UINib(nibName: cellIdentifier, bundle: nil)
    }

    public func configure(viewModel: ReviewCellViewModel) {
        self.viewModel = viewModel
        self.tableReview.reloadData()
    }
    
    @IBAction func showAddReviewScreen(_ sender: Any) {
        viewModel?.showCreateReview()
    }
}

extension ReviewsCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberReviews() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellIdentifier, for: indexPath) as! ReviewTableViewCell
        if let viewModel = viewModel {
            cell.configure(viewModel: viewModel.getTableCellViewModel(index: indexPath.row))
        }
        return cell
    }
    
    
}

