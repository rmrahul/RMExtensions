//
//  UIView.swift
//  Ouch
//
//  Created by Rahul Mane on 23/09/18.
//  Copyright © 2018 developer. All rights reserved.
//

import Foundation
import UIKit

extension CALayer {
    func addGradienBorder(colors:[UIColor],width:CGFloat = 1,rect : CGRect) {
        let objgradientLayer = CAGradientLayer()
        objgradientLayer.frame =  rect
        objgradientLayer.colors = colors
        
        let objShapeLayer = CAShapeLayer()
        objShapeLayer.lineWidth = 5
        objShapeLayer.path = UIBezierPath(rect: self.bounds).cgPath
        objShapeLayer.fillColor = UIColor.red.cgColor
        objShapeLayer.strokeColor = UIColor.black.cgColor
        objgradientLayer.mask = objShapeLayer
        
        self.addSublayer(objgradientLayer)
    }
}

extension UIView{
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
}

