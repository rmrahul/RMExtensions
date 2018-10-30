
//
//  StackView.swift
//  Ouch
//
//  Created by Rahul Mane on 29/10/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

extension UIStackView {
    public func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
