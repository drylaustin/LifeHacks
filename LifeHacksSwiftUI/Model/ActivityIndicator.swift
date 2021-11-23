//
//  ActivityIndicator.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/9/21.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
        var isAnimating: Bool = true
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

//struct ActivityIndicator_Previews: PreviewProvider {
//    static var previews: some View {
//        ActivityIndicator()
//    }
//}
