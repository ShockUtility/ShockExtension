//
//  Array+ex.swift
//  Pods
//
//  Created by shock on 2017. 5. 6..
//
//

import Foundation

public extension Array {

    // 배열내의 프로퍼티를 기준으로 그룹을 만들어서 반환한다.       ex) Array.categorise { $0.age }
    func groupBy<U : Hashable>(_ key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var dict: [U:[Iterator.Element]] = [:]
        for el in self {
            let key = key(el)
            if case nil = dict[key]?.append(el) { dict[key] = [el] }
        }
        return dict
    }
    
    func groupByKeys<U : Hashable>(_ key: (Iterator.Element) -> U) -> [U] {
        var dict: [U] = []
        for el in self {
            let key = key(el)
            
            if case nil = dict.index(of: key) {
                dict.append(key)
            }
        }
        return dict
    }
    
    // 배열을 랜덤하게 소팅 시킨다
    mutating func shuffle() {
        for _ in 0..<10 {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
