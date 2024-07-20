//
//  String+Extension.swift
//  GithubUsers
//
//  Created by Siti Norain Ishak on 20/07/2024.
//

import Foundation
import UIKit

extension String {
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: self.count))
        
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    
    public var isWhitespace: Bool {
        let whitespaceSet = NSCharacterSet.whitespacesAndNewlines
        let resultString:String = self.trimmingCharacters(in: whitespaceSet)
        if resultString.count <= 0 {
            return true
        }
        
        return false
    }
}
