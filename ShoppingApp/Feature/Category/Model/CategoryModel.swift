//
//  CategoryModel.swift
//  ShoppingApp
//
//  Created by Tushar on 15/02/20.
//  Copyright © 2020 Tushar. All rights reserved.
//

import Foundation

struct CategoryModel : Codable {
    let products : [Products]?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case products = "products"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([Products].self, forKey: .products)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
