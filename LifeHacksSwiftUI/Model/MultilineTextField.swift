//
//  MultilineTextField.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/9/21.
//

import SwiftUI

struct MultilineTextField: UIViewRepresentable {
    @Binding var text: String
    
    func makeCoordinator() -> Coordinator {
            Coordinator(textView: self)
        }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0.0
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

extension MultilineTextField {
    class Coordinator: NSObject, UITextViewDelegate {
        let textView: MultilineTextField
        
        init(textView: MultilineTextField) {
            self.textView = textView
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.textView.text = textView.text
        }
    }
}


struct MultilineTextField_Previews: PreviewProvider {
    static var previews: some View {
        MultilineTextField(text: .constant(TestData.user.aboutMe!))
            .namedPreview()
            .frame(height: 250.0)
    }
}
