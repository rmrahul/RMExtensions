//
//  UIImage.swift
//  Ouch
//
//  Created by Developer 07/09/18 .
//  Copyright © 2018 Developer . All rights reserved.
//

import UIKit

extension UITableView {
    public func refresh(){
        self.beginUpdates()
        UIView.setAnimationsEnabled(false)
        self.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
}
