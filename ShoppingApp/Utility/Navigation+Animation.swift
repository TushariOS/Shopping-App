//
//  Navigation+Animation.swift
//  ShoppingApp
//
//  Created by Tushar on 16/02/20.
//  Copyright © 2020 Tushar. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func pushViewControllerWithFlipAnimation(viewController:UIViewController){
        self.pushViewController(viewController
            , animated: false)
        if let transitionView = self.view{
            UIView.transition(with:transitionView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
}
