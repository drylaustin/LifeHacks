//
//  Motif.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/4/21.
//

import SwiftUI
struct Motif: ViewModifier {
    let role: Role
    
    @Environment(\.theme) private var theme:  Theme
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(role == .primary
                             ? theme.accentColor
                             : theme.secondaryColor)
    }
}

extension Motif {
    enum Role: String, CaseIterable {
        case primary
        case secondary
    }
}

extension View {
    func motif(_ role: Motif.Role) -> some View {
        modifier(Motif(role: role))
    }
}


struct Motif_Previews: PreviewProvider {
    static let combinations: some View = VStack(spacing: 8.0) {
        ForEach(Motif.Role.allCases, id: \.self) { role in
            Text(role.rawValue)
                .motif(role)
        }
    }
    
    static var previews: some View {
        Group {
            combinations
                .previewWithName("Default")
            combinations
                .environment(\.theme, .web)
                .previewWithName("Web")
        }
    }
}
