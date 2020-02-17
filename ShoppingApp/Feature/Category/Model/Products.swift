//
//  Product.swift
//  ShoppingApp
//
//  Created by Tushar on 15/02/20.
//  Copyright © 2020 Tushar. All rights reserved.
//

import Foundation

struct Products : Codable {
    let sku : Int?
    let name : String?
    let cost : Int?

    enum CodingKeys: String, CodingKey {
        case sku = "sku"
        case name = "name"
        case cost = "cost"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sku = try values.decodeIfPresent(Int.self, forKey: .sku)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        cost = try values.decodeIfPresent(Int.self, forKey: .cost)
    }
}
