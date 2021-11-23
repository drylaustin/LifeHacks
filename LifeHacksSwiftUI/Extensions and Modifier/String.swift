//
//  String.swift
//  LifeHacksSwiftUI
//
//  Created by DARYL AGUSTIN on 11/13/21.
//

import Foundation

extension String {
    var htmlString: NSAttributedString? {
        guard let htmlData = self.data(using: .unicode) else { return nil }
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
        return try? NSAttributedString(data: htmlData, options: options, documentAttributes: nil)
    }
    
    var plainHtmlString: String {
            return htmlString?.string ?? ""
        }
}
