//
//  UIScreen+ex.swift
//  Pods
//
//  Created by shock on 2017. 5. 8..
//
//

import UIKit

public extension UIScreen {
    
    static func realSize(orientation: UIInterfaceOrientation) -> CGSize {
        let size = UIScreen.main.bounds.size
        let realSize = CGSize(width: min(size.width, size.height), height: max(size.width, size.height))
        
        return orientation.isPortrait ?  realSize : CGSize(width: realSize.height, height: realSize.width)
    }
    
    static func realSize(isLandscape: Bool) -> CGSize {
        let size = UIScreen.main.bounds.size
        let realSize = CGSize(width: min(size.width, size.height), height: max(size.width, size.height))
        
        return isLandscape ? CGSize(width: realSize.height, height: realSize.width) : realSize
    }
}
