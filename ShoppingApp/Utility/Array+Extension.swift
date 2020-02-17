//
//  Array+Extension.swift
//  ShoppingApp
//
//  Created by Tushar on 17/02/20.
//  Copyright © 2020 Tushar. All rights reserved.
//

import Foundation

/// Return unique value from array
extension Array {
    func uniqueValues<V:Equatable>( value:(Element)->V) -> [Element] {
        var result:[Element] = []
        for element in self {
            if !result.contains(where: { value($0) == value(element) }) { result.append(element) }
        }
        return result
    }
}
