//
//  LoadingIndicator.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/16/21.
//

import SwiftUI

struct LoadingIndicator: View {
    let isLoading: Bool
    
    var body: some View {
        if isLoading{
            ProgressView()
                .frame(maxWidth: .infinity)
        } else {
            EmptyView()
        }
    }
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicator(isLoading: true)
            .namedPreview()
    }
}
