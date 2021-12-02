//
//  OrdersTableViewController.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 24.10.21.
//

import UIKit
import SideMenu

class OrdersTableViewController: UITableViewController {
    
    private var refreshView = UIRefreshControl()
    private var viewModel: OrdersViewModel = OrdersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        refreshView = UIRefreshControl()
        refreshView.attributedTitle = NSAttributedString(string: "Обновление данных")
        refreshView.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshView)
        tableView.register(OrderTableViewCell.nib(), forCellReuseIdentifier: OrderTableViewCell.cellIdentifier)
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        viewModel.errorMessage = { [weak self] message in
            self?.showErrorAlert(and: message)
        }
        
        viewModel.reloadData = { [weak self] in
            self?.tableView.reloadData()
            self?.refreshView.endRefreshing()
        }
    }

    @IBAction func showSideMenu(_ sender: Any) {
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
    
    func createSettingsSideMenu() -> SideMenuSettings {
        var settings = SideMenuSettings()
        settings.presentationStyle = .menuSlideIn
        settings.statusBarEndAlpha = 0
        settings.menuWidth = min(UIScreen.main.bounds.width - 50, 500);
        return settings
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.updateOrders()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfOrders()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellIdentifier, for: indexPath) as! OrderTableViewCell
        cell.configure(viewModel: viewModel.getOrderCellViewModel(index: indexPath.row))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
