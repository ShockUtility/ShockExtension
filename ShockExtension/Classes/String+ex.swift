//
//  String+ex.swift
//  Pods
//
//  Created by shock on 2017. 5. 6..
//
//

import Foundation

public extension String {
    
    subscript (i: Int) -> Character {
        return Array(self.characters)[i]
    }
    
    subscript (r: CountableClosedRange<Int>) -> String {
        if r.upperBound >= self.characters.count {
            return self[r.lowerBound...self.characters.count-1]
        }
        return String(Array(self.characters)[r])
    }
    
    subscript (r: CountableRange<Int>) -> String {
        return self[r.lowerBound...r.upperBound-1]
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var validateUrl: Bool {
        let urlRegEx = "^https?://[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?$"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
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
#if swift(>=3.2)
            return String(self[start...])
#else
            return self.substring(from: start)
#endif
        }
        return self
    }
    
    var encodedUrlParam: String? { // 특정 URL 뒤에 파라미터로 연결하기 위해 퍼센트 엔코딩된 문자열을 반환
        return self.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed)
    }
    
    var encodedUrl: URL? {
        return URL(string: self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
