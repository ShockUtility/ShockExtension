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
        let log = String(format: "[printLog][%@] >>> %@ [%04d][%@]", time, joind, line, function)
        
        print(log)
    #endif
}
