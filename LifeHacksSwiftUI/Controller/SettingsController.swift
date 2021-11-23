//
//  SettingsController.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/12/21.
//

import Foundation

class SettingsController: ObservableObject {
    @Published var theme: Theme {
        didSet { defaults.set(theme.name, forKey: LifeHacksSwiftUIApp.Keys.themeName) }
    }
        private let defaults = UserDefaults.standard
    
    init() {
        let themeName = defaults.string(forKey: LifeHacksSwiftUIApp.Keys.themeName) ?? ""
        theme = Theme.named(themeName) ?? .default
    }
    
  
}
