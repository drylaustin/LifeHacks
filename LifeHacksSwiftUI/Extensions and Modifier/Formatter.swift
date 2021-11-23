//
//  Formatter.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 10/26/21.
//

import Foundation

extension Int {
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
