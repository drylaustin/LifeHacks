//
//  PageControl.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/9/21.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    @Binding var currentPage: Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(pageControl: self)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.addTarget(context.coordinator, action: #selector(Coordinator.getPage), for: .touchUpInside)
        return pageControl
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}
 
extension PageControl {
    class Coordinator {
        let pageControl: PageControl
        
        init(pageControl: PageControl) {
            self.pageControl = pageControl
        }
        
        @objc func getPage(sender: UIPageControl) {
            pageControl.currentPage = sender.currentPage
        }
    }
}
