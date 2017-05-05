//
//  Int+ex.swift
//  Pods
//
//  Created by shock on 2017. 5. 6..
//
//

import Foundation

public extension Int {
    
    fileprivate func sizeFormatString(_ divider: Double, _ tokens:[String], _ format:String) -> String {
        var doubleValue = Double(self)
        var factor = 0
        
        while doubleValue >= divider {
            doubleValue /= divider
            factor += 1
        }
        
        return String(format: format, doubleValue, tokens[factor])
    }
    
    var displaySmallCount:String {
        return sizeFormatString(1000, ["", "K+", "M+", "G+", "T+", "P+",  "E+",  "Z+", "Y+"], "%.0f%@")
    }
    
    var displayFileSize:String {
        return sizeFormatString(1000, ["", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"], "%0.1f %@")
    }
    
    var decimal: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
