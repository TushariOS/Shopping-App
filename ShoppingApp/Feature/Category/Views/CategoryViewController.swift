//
//  CategoryViewController.swift
//  ShoppingApp
//
//  Created by Tushar on 15/02/20.
//  Copyright © 2020 Tushar. All rights reserved.
//

import UIKit

/// CategoryViewController
final class CategoryViewController: UIViewController {
    
    private struct ConstantKeys {
        static let largeCategoryCell = "LargeCategoryTableViewCell"
        static let subCategoryTableViewCell = "SubCategoryTableViewCell"
        static let tableViewHeader = "TableViewHeader"
        static let smallHeight: CGFloat = 44.0
        static let largeHeight: CGFloat = 219.0
    }
    
    /// Tableview for display data in verticale
    @IBOutlet private weak var tableView: UITableView!
    
    /// It's flag for display data in list or large view format
    private var isListTableView = false
    
    /// View model object
    let viewModel = ViewModel.shared
    
    //MARK: - Lifecycle Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableview()
        
        viewModel.getCategory() {[weak self] error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.alertView(messgae: error)
                }
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Private methodes
    
    /// Set up table view
    private func setupTableview() {
        tableView.estimatedRowHeight = 499
        tableView.register(UINib(nibName: ConstantKeys.largeCategoryCell, bundle: nil), forCellReuseIdentifier: ConstantKeys.largeCategoryCell)
        
        tableView.register(UINib(nibName: ConstantKeys.subCategoryTableViewCell, bundle: nil), forCellReuseIdentifier: ConstantKeys.subCategoryTableViewCell)
        
        let headerNib = UINib.init(nibName: ConstantKeys.tableViewHeader, bundle: Bundle.main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: ConstantKeys.tableViewHeader)
    }
    
    private func alertView(messgae: String) {
        let alert = UIAlertController(title: "Error", message: messgae, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style {
              case .default:
                    print("default")
              case .cancel:
                    print("cancel")
              case .destructive:
                    print("destructive")
              @unknown default:
                break
            }}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func switchAction(_ sender: Any) {
        isListTableView = !isListTableView
        tableView.reloadData()
    }
}


//MARK: - Tableview UITableViewDataSource

extension CategoryViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isListTableView ? viewModel.listOfCategoryModel.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isListTableView ? viewModel.listOfCategoryModel[section].products.count : viewModel.listOfCategoryModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: ConstantKeys.subCategoryTableViewCell, for: indexPath) as! SubCategoryTableViewCell
            cell.subCategoryLabel?.text = viewModel.listOfCategoryModel[indexPath.section].products[indexPath.row].name ?? ""
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ConstantKeys.largeCategoryCell, for: indexPath) as! LargeCategoryTableViewCell
            cell.setupCellData(displayModel: viewModel.listOfCategoryModel[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
}


//MARK: - Tableview UITableViewDelegate

extension CategoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return isListTableView ? getHeightForList(section: indexPath.section) : ConstantKeys.largeHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isListTableView ? ConstantKeys.smallHeight : CGFloat(0.0)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ConstantKeys.tableViewHeader) as! TableViewHeader        
        headerView.setupHeaderView(title: viewModel.listOfCategoryModel[section].name, section: section)
        headerView.delegate = self
        return headerView
    }
    
    /// Return height of cell
    /// - Parameter section: Tableview section
    private func getHeightForList(section: Int) -> CGFloat {
        if viewModel.listOfCategoryModel[section].isExpand {
            return ConstantKeys.smallHeight
        } else {
            return CGFloat(0.0)
        }
    }
}

/// Implementing the protocol  of LargeCategoryTableViewCell for navigation action
extension CategoryViewController: ProductProtocol {
    func tappedOnProduct(imageurlString: String) {
        guard let viewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProductImageViewController") as? ProductImageViewController else {
            fatalError("ViewController not found")
        }
        viewController.imgaeurlString = imageurlString;
        self.navigationController?.pushViewControllerWithFlipAnimation(viewController: viewController)
    }
}

    /// Implementing the protocl of Header view for expandable and collabse tableview.
extension CategoryViewController: ExpandableHeaderViewDelegate {
    func toggleSection(header: TableViewHeader, section: Int) {
        
        for i in 0..<viewModel.listOfCategoryModel.count {
            if section == i {
                tableView.beginUpdates()
                viewModel.listOfCategoryModel[section].isExpand = !viewModel.listOfCategoryModel[section].isExpand
                for i in 0 ..< viewModel.listOfCategoryModel.count {
                    self.tableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
                }
                tableView.endUpdates()
            } else {
                viewModel.listOfCategoryModel[i].isExpand = false
            }
        }
    }
}
