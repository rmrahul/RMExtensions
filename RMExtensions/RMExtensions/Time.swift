//
//  Time.swift
//  Ouch
//
//  Created by Rahul Mane on 29/10/18.
//  Copyright © 2018 developer. All rights reserved.
//

import UIKit

public struct Time {
    let start: TimeInterval
    let end: TimeInterval
    let interval: TimeInterval
    
    public init(start: TimeInterval, interval: TimeInterval, end: TimeInterval) {
        self.start = start
        self.interval = interval
        self.end = end
    }
    
    public init(startHour: TimeInterval, intervalMinutes: TimeInterval, endHour: TimeInterval) {
        self.start = startHour * 60 * 60
        self.end = endHour * 60 * 60
        self.interval = intervalMinutes * 60
    }
    
    public var timeRepresentations: [String] {
        let dateComponentFormatter = DateComponentsFormatter()
        dateComponentFormatter.unitsStyle = .positional
        dateComponentFormatter.allowedUnits = [.minute, .hour]
        
        let dateComponent = NSDateComponents()
        return timeIntervals.map { timeInterval in
            dateComponent.second = Int(timeInterval)
            return dateComponentFormatter.string(from: dateComponent as DateComponents)!
        }
    }
    
    public var timeIntervals: [TimeInterval]{
        return Array(stride(from: start, through: end, by: interval))
    }
}
