//
//  ViewController.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 30.09.21.
//

import UIKit
import SideMenu
import RSSelectionMenu
import CoreLocation

class ServicesListViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var partnersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    private var refreshView = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let location = CLLocationManager()
    
    lazy var viewModel: ServiceListViewModel = {
        return ServiceListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.requestAlwaysAuthorization()
        viewModel.setLatLon(lat: 53.894424, lon: 27.532360, updateData: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        viewModel.setLatLon(lat: location.location?.coordinate.latitude, lon: location.location?.coordinate.longitude, updateData: true)
    }
    
    func initView() {
        title = ""
        searchBar.delegate = self
        initCollectionView()
        initTableView()
        createActivityIndicator()
        hideKeyboardWhenTappedAround()
    }
    
    func initCollectionView() {
        filterCollectionView.register(CarTypeCollectionViewCell.nib(), forCellWithReuseIdentifier: CarTypeCollectionViewCell.cellIdentifier)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        viewModel.reloadFilter = { [weak self] in
            self?.filterCollectionView.reloadData()
        }
    }
    
    func initTableView() {
        refreshView = UIRefreshControl()
        refreshView.attributedTitle = NSAttributedString(string: "Обновление данных")
        refreshView.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        partnersTableView.addSubview(refreshView)
        partnersTableView.register(ServiceViewCell.nib(), forCellReuseIdentifier: ServiceViewCell.cellIdentifier)
        partnersTableView.delegate = self
        partnersTableView.dataSource = self
        viewModel.reloadPartners = { [weak self] in
            self?.partnersTableView.reloadData()
            self?.stopActivityIndicator()
        }
        
        viewModel.stopLoadIndicator = { [weak self] in
            self?.stopActivityIndicator()
        }
        
        viewModel.startLoadIndicator = { [weak self] in
            self?.startActivityIndicator()
        }
        
        viewModel.stopReloadIndicator = { [weak self] in
            self?.refreshView.endRefreshing()
        }
    }

    func createActivityIndicator() {
        activityIndicator.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: partnersTableView.bounds.width, height: CGFloat(50))
        partnersTableView.tableFooterView = activityIndicator
        partnersTableView.tableFooterView?.isHidden = true
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
        partnersTableView.tableFooterView?.isHidden = false
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        partnersTableView.tableFooterView?.isHidden = true
    }
    
    @IBAction func showLeftMenu(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "SideMenu", bundle:nil)
        let menu = storyBoard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenuNavigationController
        menu.settings = createSettingsSideMenu()
        SideMenuManager.default.leftMenuNavigationController = menu
        if let navController = navigationController {
            SideMenuManager.default.addPanGestureToPresent(toView: navController.navigationBar)
            SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: navController.view)
        }
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func showFilterMenu(_ sender: Any) {
        let selectionMenu = RSSelectionMenu(selectionStyle: .multiple, dataSource: viewModel.getWorksType()) { (cell, workType, indexPath) in
            cell.textLabel?.text = workType.name
        }
        selectionMenu.onDismiss = { [weak self] items in
            self?.viewModel.updateSelectedWorksType(selectedWorksType: items)
        }
        selectionMenu.setSelectedItems(items: viewModel.getSelectedWorksType()) { (text, index, isSelected, selectedItems) in }
        selectionMenu.cellSelectionStyle = .checkbox
        selectionMenu.show(style: .actionSheet(title: "Фильтр по услугам", action: "Применить", height: nil), from: self)
    }
    
    func createSettingsSideMenu() -> SideMenuSettings {
        var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.statusBarEndAlpha = 0
        settings.menuWidth = min(UIScreen.main.bounds.width - 50, 500);
        return settings
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.refreshPartners()
    }
}

extension ServicesListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberGroupsCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarTypeCollectionViewCell.cellIdentifier, for: indexPath) as! CarTypeCollectionViewCell
        cell.configure(viewModel: viewModel.getGroupViewModelById(id: indexPath.row))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellViewModel = viewModel.getGroupViewModelById(id: indexPath.row)
        let width = cellViewModel.name.widthOfString(font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body))
        return CGSize(width: width + 40, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.changeSelectedFilterId(index: indexPath.row)
        filterCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        searchBar.endEditing(true)
    }
}

extension ServicesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberPartnerCell()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceViewCell.cellIdentifier, for: indexPath) as! ServiceViewCell
        cell.configure(viewModel: viewModel.getPartnerViewModelById(id: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       let lastSectionIndex = tableView.numberOfSections - 1
       let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
       if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
           viewModel.loadMoreData()
       }
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard : UIStoryboard = UIStoryboard(name: "ServiceInfo", bundle:nil)
        let serviceInfoVC = storyBoard.instantiateViewController(withIdentifier: "ServiceInfoVC") as! ServiceInfoViewController
        serviceInfoVC.viewModel = viewModel.getServiceInfoViewModel(index: indexPath.row)
        navigationController?.pushViewController(serviceInfoVC, animated: true)
        searchBar.endEditing(true)
    }
}

extension ServicesListViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.keyupSearchBar(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}
