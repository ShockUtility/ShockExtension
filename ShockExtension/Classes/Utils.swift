//
//  Utils.swift
//  Pods
//
//  Created by shock on 2017. 8. 21..
//
//

import Foundation

public func printLog(_ items: Any..., function: String = #function, line: Int = #line ) {
    #if DEBUG
        let logFormatter = DateFormatter()
        logFormatter.dateFormat = "mm:ss.SSS"
        let time = logFormatter.string(from: Date())
        let joind = items.map { "\($0)" }.joined(separator: " ")
        
        var fname = function[0..<32]
        for _ in fname.characters.count..<32 {
            fname.append("_")
        }
        print(String(format: "[printLog][%@][%@][%05d] >>> %@ ", fname, time, line, joind))
    #endif
}
