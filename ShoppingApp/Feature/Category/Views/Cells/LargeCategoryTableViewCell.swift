//
//  LargeCategoryTableViewCell.swift
//  ShoppingApp
//
//  Created by Tushar on 15/02/20.
//  Copyright © 2020 Tushar. All rights reserved.
//

import UIKit

/// Protocol for action on product cell.
protocol ProductProtocol: class {
    func tappedOnProduct(imageurlString: String)
}

/// Large Category TableViewCell
final class LargeCategoryTableViewCell: UITableViewCell {
    
    /// Private struct conatin identifier key
    private struct CollectionViewConstant {
        static let cellIdentifier = "ProductCollectionViewCell"
        static let imageUrlString =  "https://systane.myalcon.com/sites/g/files/rbvwei411/files/2019-12/3d-systane_ultra-10ml-sbs-ctn_btl-usa-f_left.png"
    }
    
    // MARK: - IBOutlet

    @IBOutlet private weak var categoryNameLabel: UILabel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    weak var delegate: ProductProtocol?
    
    private var displayModel: DisplayModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }
    
    /// Display table view data
    /// - Parameter displayModel: Display model object
    func setupCellData(displayModel: DisplayModel) {
        categoryNameLabel.text = displayModel.name
        self.displayModel = displayModel
        collectionView.reloadData()
    }
    
    // MARK: Private methods
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: CollectionViewConstant.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: CollectionViewConstant.cellIdentifier)
    }
    
    /// Sort action
    /// - Parameter sender: Any
    @IBAction func sortButtonAction(_ sender: Any) {
        
        let sortedUsers = displayModel.products.sorted {
            $0.cost ?? 0 < $1.cost ?? 0
        }
          displayModel.updateProduct(updatedProducts: sortedUsers)
        collectionView.reloadData()
    }
}

    /// UICollectionViewDataSource
extension LargeCategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayModel.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewConstant.cellIdentifier, for: indexPath) as! ProductCollectionViewCell
        cell.priceLabel.text = "Rs. \(displayModel.products[indexPath.row].cost!)/-"
        cell.productImage.sd_setImage(with: URL(string: CollectionViewConstant.imageUrlString), placeholderImage: UIImage(named: "placeholderImage"))
        return cell
    }
}

    /// UICollectionViewDelegate
extension LargeCategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.tappedOnProduct(imageurlString: CollectionViewConstant.imageUrlString)
    }
}

    /// UICollectionViewDelegateFlowLayout
extension LargeCategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.contentView.frame.size.width - 20) / 3, height: (collectionView.frame.size.height - 20) / 3)
    }
}
