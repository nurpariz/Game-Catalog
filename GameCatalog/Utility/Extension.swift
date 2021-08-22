//
//  Extension.swift
//  GameCatalog
//
//  Created by Nurpariz Muhammad on 21/08/21.
//

import Foundation
import UIKit

extension UIImageView {
    func setCornerRadius() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.913613975, green: 0.9137097001, blue: 0.9176982641, alpha: 1)
        layer.masksToBounds = true
    }
}

extension DateFormatter {
    func convertDateFormat(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "MMM d, yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
}

extension String {
    var utfData: Data? {
        return self.data(using: .utf8)
    }
    
    var htmlAttributedString: NSAttributedString? {
        guard let data = self.utfData else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,
                                          options: [
                                            .documentType: NSAttributedString.DocumentType.html,
                                            .characterEncoding: String.Encoding.utf8.rawValue
                                          ], documentAttributes: nil)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    var htmlString: String {
        return htmlAttributedString?.string ?? self
    }
}
