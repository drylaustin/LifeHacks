//
//  ContentSizeCategory.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/4/21.
//


import SwiftUI

struct AdaptiveView<Standard: View, Large: View>: View{
    let standard: Standard
    let large: Large
    
    @Environment(\.sizeCategory) private var sizeCategory
    
    var body: some View {
            Group {
                if sizeCategory.isLarge {
                    large
                } else {
                    standard
                }
            }
        }
    }
    


extension ContentSizeCategory {
    var isLarge: Bool {
        let largeCategories: [ContentSizeCategory] = [
            .accessibilityLarge,
            .accessibilityExtraLarge,
            .accessibilityExtraExtraLarge,
            .accessibilityExtraExtraExtraLarge]
        return largeCategories.contains(self)
    }
}
