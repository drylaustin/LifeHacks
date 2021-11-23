//
//  Previews.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 10/30/21.
//

import Foundation
import SwiftUI

extension View {
    func previewWithName(_ name: String) -> some View {
        self
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName(name)
    }
    func namedPreview() -> some View {
        let name = String.name(for: type(of: self))
        return previewWithName(name)
    }
    func fullScreenPreviews(showAll: Bool = false) -> some View {
        Group {
            if !showAll {
                self
            } else {
                ForEach(Theme.allThemes) { theme in
                    ForEach(ColorScheme.allCases) { colorScheme in
                        self
                            .previewTheme(theme, colorScheme: colorScheme)
                    }
                }
                self
                    .xxxlPreview()
                self
                    .iPhoneSEPreview()
            }
        }
    }
    
    func previewTheme(_ theme: Theme, colorScheme: ColorScheme) -> some View {
        self
            .background(Color(.systemBackground))
            .environment(\.theme, theme)
            .accentColor(theme.accentColor)
            .previewDisplayName(theme.name + ", " + colorScheme.name)
            .environment(\.colorScheme, colorScheme)
    }
    
    func xxxlPreview() -> some View {
        self
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            .previewDisplayName("Accessibility XXXL")
    }
    
    func iPhoneSEPreview() -> some View {
        self
            .previewDevice("iPhone SE (2nd generation)")
            .previewDisplayName("iPhone SE (2nd generation)")
    }
}
extension String {
    static func name<T>(for type: T) -> String {
        String(reflecting: type)
            .components(separatedBy: ".")
            .last ?? ""
    }
}
