//
//  LifeHacksSwiftUIApp.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 10/24/21.
//

import SwiftUI

@main
struct LifeHacksSwiftUIApp: App {
    @StateObject private var stateController = StateController()
    @StateObject private var settingsController = SettingsController()
        
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(stateController)
                .environmentObject(settingsController)
        }
    }
}

extension LifeHacksSwiftUIApp {
    struct Keys {
        static let themeName = "ThemeName"
        static let isLoggedIn = "IsLoggedIn"
    }
}
