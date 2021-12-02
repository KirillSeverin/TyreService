//
//  MenuTableViewController.swift
//  TyreService
//
//  Created by ULADZISLAU SHURYN on 19.10.21.
//

import UIKit

class MenuTableViewController: UITableViewController {

    private var isAuth: Bool = UserDefaults.standard.string(forKey: "token") != nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return isAuth ? 0 : 80
        case 1:
            return isAuth ? 80 : 0
        case 2:
            return isAuth ? 80 : 0
        case 4:
            return isAuth ? 80 : 0
        default:
            return 80
        }
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let storyBoard = UIStoryboard(name: "Authorization", bundle: nil)
            let authorizationVC = storyBoard.instantiateViewController(withIdentifier: "AuthorizationVC") as! AuthorizationViewController
            navigationController?.pushViewController(authorizationVC, animated: false)
        case 1:
            let storyBoard = UIStoryboard(name: "PartnerCabinet", bundle: nil)
            let partherCabinet = storyBoard.instantiateViewController(withIdentifier: "PartnerCabinetVC") as! PartnerCabinetViewController
            navigationController?.pushViewController(partherCabinet, animated: false)
        case 2:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Orders", bundle:nil)
            let servicesListVC = storyBoard.instantiateViewController(withIdentifier: "OrdersTableVC") as! OrdersTableViewController
            navigationController?.pushViewController(servicesListVC, animated: false)
        case 3:
            let storyBoard: UIStoryboard = UIStoryboard(name: "ServiceList", bundle:nil)
            let servicesListVC = storyBoard.instantiateViewController(withIdentifier: "ServicesListVC") as! ServicesListViewController
            navigationController?.pushViewController(servicesListVC, animated: false)
        case 4:
            UserDefaults.standard.removeObject(forKey: "token")
            let storyBoard: UIStoryboard = UIStoryboard(name: "ServiceList", bundle:nil)
            let servicesListVC = storyBoard.instantiateViewController(withIdentifier: "ServicesListVC") as! ServicesListViewController
            navigationController?.pushViewController(servicesListVC, animated: false)
            break
        default:
            break
        }
    }

}
