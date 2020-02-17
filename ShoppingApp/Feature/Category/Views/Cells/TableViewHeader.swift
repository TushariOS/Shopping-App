//
//  TableViewHeader.swift
//  ShoppingApp
//
//  Created by Tushar on 16/02/20.
//  Copyright © 2020 Tushar. All rights reserved.
//

import UIKit

/// Expandable Header ViewDelegate
protocol ExpandableHeaderViewDelegate: class {
      func toggleSection(header: TableViewHeader, section: Int)
}

/// <#Description#>
final class TableViewHeader: UITableViewHeaderFooterView {
    
    /// Header title lable
    @IBOutlet weak var mainMenuLabel: UILabel!
    
    /// Delegate
    weak var delegate:ExpandableHeaderViewDelegate?
    
    /// Section capture int value
    var section:Int!
    
    override func awakeFromNib() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(selectHeaderAction)))
    }
    
    /// Add tap gesture action header view
    /// - Parameter gestureRecognizer: UITapGestureRecognizer
    @objc func selectHeaderAction(gestureRecognizer:UITapGestureRecognizer) {
        let cell = gestureRecognizer.view as! TableViewHeader
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    /// Set data to header view
    /// - Parameters:
    ///   - title: Set header title
    ///   - section: Set int value to section
    func setupHeaderView(title: String, section: Int) {
        mainMenuLabel.text = title
        self.section = section
    }
}
