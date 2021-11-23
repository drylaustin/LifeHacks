//
//  Theme.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 10/31/21.
//

import Foundation
import SwiftUI

struct Theme: Identifiable {
    let name: String
    let accentColor: Color
    let secondaryColor: Color
    let primaryGradient: LinearGradient
    let secondaryGradient: LinearGradient
    
    var id: String { name }
    
    static let `default` = Theme(
        name: "Default",
        accentColor: .blue,
        secondaryColor: .orange,
        primaryGradient: .blue,
        secondaryGradient: .orange)
    
    static let web = Theme(
        name: "Web",
        accentColor: .teal,
        secondaryColor: .green,
        primaryGradient: .teal,
        secondaryGradient: .green)
    
    static let allThemes: [Theme] = [.default, .web]
    
    static func named(_ name: String) -> Theme? {
        allThemes.first(where: { $0.name == name })
    }
}

struct ThemeKey : EnvironmentKey {
    static let defaultValue = Theme.default
}

extension EnvironmentValues {
    var theme: Theme{
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}

extension ColorScheme: Identifiable {
    public var id: String { name }
    
    var name : String {
        switch self{
        case .light: return "Light"
        case .dark: return "Dark"
        @unknown default:
            fatalError()
        }
    }
}
