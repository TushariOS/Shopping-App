//
//  ProductCollectionViewCell.swift
//  ShoppingApp
//
//  Created by Tushar on 15/02/20.
//  Copyright © 2020 Tushar. All rights reserved.
//

import UIKit
import SDWebImage

final class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
