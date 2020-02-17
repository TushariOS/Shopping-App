//
//  DisplayModel.swift
//  ShoppingApp
//
//  Created by Tushar on 15/02/20.
//  Copyright © 2020 Tushar. All rights reserved.
//

import Foundation

struct DisplayModel {
    var name: String
    var products: [Products]
    var isExpand: Bool = false
    
    init(name: String, products: [Products]) {
        self.name = name
        self.products = products
    }
    
    mutating func updateProduct(updatedProducts: [Products]) {
        self.products = updatedProducts
    }
}
