//
//  ServiceInfoViewController.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 12.10.21.
//

import UIKit
import Kingfisher

class ServiceInfoViewController: UIViewController {

    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var serviceNameView: UIView!
    @IBOutlet weak var serviceNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    weak var viewModel: ServiceInfoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func initView() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        serviceNameView.layer.cornerRadius = 8
        serviceNameLabel.text = viewModel.getServiceName()
        if let imageUrl = viewModel.getImageUrl() {
            imageView.kf.setImage(with: imageUrl)
        }
        initMenuCollectionView()
        initInfoCollectionView()
        viewModel.showRegistrationWorks = { [weak self] in
            let storyBoard : UIStoryboard = UIStoryboard(name: "RequestWorks", bundle:nil)
            if let registrationWorksVC = storyBoard.instantiateViewController(withIdentifier: "RequestWorksVC") as? RequestWorksViewController {
                registrationWorksVC.viewModel = self?.viewModel.getRegistrationWorksViewModel()
                self?.present(registrationWorksVC, animated: true, completion: nil)
            }
        }
        
        viewModel.showCreateReview = { [weak self] in
            let storyBoard : UIStoryboard = UIStoryboard(name: "CreateReview", bundle:nil)
            if let createReviewVC = storyBoard.instantiateViewController(withIdentifier: "CreateReviewVC") as? CreateReviewViewController {
                createReviewVC.viewModel = self?.viewModel.getCreateReviewViewModel()
                createReviewVC.handlerSuccessAddReview = { [weak self] in
                    self?.viewModel.getFullInfoService()
                }
                self?.present(createReviewVC, animated: true, completion: nil)
            }
        }
    }
    
    func initMenuCollectionView() {
        menuCollectionView.register(MenuServiceInfoCollectionViewCell.nib(), forCellWithReuseIdentifier: MenuServiceInfoCollectionViewCell.cellIdentifier)
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        menuCollectionView.layer.cornerRadius = 8
        viewModel.reloadMenu = { [weak self] in
            self?.menuCollectionView.reloadData()
        }
    }
    
    func initInfoCollectionView() {
        infoCollectionView.register(AboutServiceCollectionViewCell.nib(), forCellWithReuseIdentifier: AboutServiceCollectionViewCell.cellIdentifier)
        infoCollectionView.register(ContactsCollectionViewCell.nib(), forCellWithReuseIdentifier: ContactsCollectionViewCell.cellIdentifier)
        infoCollectionView.register(ReviewsCollectionViewCell.nib(), forCellWithReuseIdentifier: ReviewsCollectionViewCell.cellIdentifier)
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
        viewModel.reloadInfo = { [weak self] in
            self?.infoCollectionView.reloadData()
        }
    }
}

extension ServiceInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberMenuItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == infoCollectionView {
            switch indexPath.row {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AboutServiceCollectionViewCell.cellIdentifier, for: indexPath) as! AboutServiceCollectionViewCell
                cell.configure(viewModel: viewModel.getAboutServiceCellViewModel())
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactsCollectionViewCell.cellIdentifier, for: indexPath) as! ContactsCollectionViewCell
                cell.configure(viewModel: viewModel.getContactsCellViewModel())
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsCollectionViewCell.cellIdentifier, for: indexPath) as! ReviewsCollectionViewCell
                cell.configure(viewModel: viewModel.getReviewsCellViewModel())
                return cell
            }
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuServiceInfoCollectionViewCell.cellIdentifier, for: indexPath) as! MenuServiceInfoCollectionViewCell
        cell.configure(viewModel: viewModel.getMenuItemViewModel(index: indexPath.row))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == infoCollectionView {
            return CGSize(width: UIScreen.main.bounds.width - 30, height: collectionView.frame.height)
        }
        return CGSize(width: (UIScreen.main.bounds.width - 40) / 3, height: collectionView.frame.height)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == menuCollectionView {
            viewModel.changeSelectedMenuItem(index: indexPath.row)
            infoCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == menuCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == infoCollectionView {
            if let visibleCell = infoCollectionView.visibleCells.first, let indexPath = infoCollectionView.indexPath(for: visibleCell) {
                viewModel.changeSelectedMenuItem(index: indexPath.row)
            }
        }
    }
}
