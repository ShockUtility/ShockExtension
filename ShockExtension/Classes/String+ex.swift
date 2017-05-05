//
//  String+ex.swift
//  Pods
//
//  Created by shock on 2017. 5. 6..
//
//

import Foundation

public extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func countOfMatchs(pattern: String, options: NSRegularExpression.Options = .caseInsensitive) -> Int {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            return regex.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
        } catch {}
        
        return 0
    }
    
    func hasMatch(prefixs: String) -> Bool {
        let comp = prefixs.components(separatedBy: "|")
        for prefix in comp {
            if self.hasPrefix(prefix) {
                return true
            }
        }
        return false
    }
    
    func hasMatch(pattern: String) -> Bool {
        return countOfMatchs(pattern: pattern) > 0
    }
    
    func hasMatch(patterns: [String]) -> Bool {
        for pattern in patterns {
            if hasMatch(pattern:pattern) {
                return true
            }
        }
        return false
    }
    
    func hasPrefixAfter(_ prefix: String) -> String {
        if self.hasPrefix(prefix) {
            let start = self.index(self.startIndex, offsetBy:prefix.characters.count)
            return self.substring(from: start)
        }
        return self
    }
}
