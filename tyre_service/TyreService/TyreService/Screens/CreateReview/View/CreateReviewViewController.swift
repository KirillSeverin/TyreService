//
//  CreateReviewViewController.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 24.10.21.
//

import UIKit

class CreateReviewViewController: UIViewController {

    @IBOutlet var starViewCollection: [UIImageView]!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var buttonSaveReview: UIButton!
    
    weak var viewModel: CreateReviewViewModel?
    public var handlerSuccessAddReview: () -> Void = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        hideKeyboardWhenTappedAround(changeViewSize: false)
    }
    
    private func initView() {
        buttonSaveReview.layer.cornerRadius = 8
        buttonSaveReview.layer.borderWidth = 1
        buttonSaveReview.layer.borderColor = UIColor(named: "buttonBorderColor")?.cgColor
        
        descriptionTextView.layer.cornerRadius = 8
        descriptionTextView.layer.borderWidth = 1
        descriptionTextView.layer.borderColor = UIColor.systemGray5.cgColor
        
        starViewCollection.forEach { view in
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.starViewTapped))
            view.addGestureRecognizer(tapGR)
            view.isUserInteractionEnabled = true
        }
        
        viewModel?.showErrorMessage = { [weak self] message in
            self?.showErrorAlert(and: message)
        }
        
        viewModel?.successAddReview = { [weak self] in
            self?.handlerSuccessAddReview()
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func starViewTapped(sender: UITapGestureRecognizer) {
        if let selectedStarTag = sender.view?.tag {
            starViewCollection.forEach { starView in
                if selectedStarTag >= starView.tag {
                    starView.tintColor = #colorLiteral(red: 0.9882352941, green: 0.7607843137, blue: 0, alpha: 1)
                } else {
                    starView.tintColor = UIColor.systemGray4
                }
            }
            viewModel?.updateRating(rating: selectedStarTag + 1)
        }
    }
    
    @IBAction func actionSaveReview(_ sender: Any) {
        viewModel?.saveReview(name: nameLabel.text ?? "", description: descriptionTextView.text)
    }
}
