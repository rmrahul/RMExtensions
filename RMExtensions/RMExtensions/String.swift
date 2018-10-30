//
//  String.swift
//  Ouch
//
//  Created by Rahul Mane on 14/10/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

extension String {
    public var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}

