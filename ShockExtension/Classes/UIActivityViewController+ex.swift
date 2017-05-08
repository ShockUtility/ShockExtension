//
//  UIActivityViewController.swift
//  Pods
//
//  Created by shock on 2017. 5. 8..
//
//

import UIKit

public extension UIActivityViewController {
    
    @discardableResult
    convenience init(_ controller:UIViewController, barButtonItem: UIBarButtonItem, url: URL) {
        self.init(activityItems: [url], applicationActivities: [TOActivitySafari(), TOActivityChrome()])
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.barButtonItem = barButtonItem
        controller.present(self, animated: true, completion: nil)
    }
    
    @discardableResult
    convenience init(_ controller:UIViewController, sourceView: UIView, url: URL) {
        self.init(activityItems: [url], applicationActivities: [TOActivitySafari(), TOActivityChrome()])
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.sourceView = sourceView
        controller.present(self, animated: true, completion: nil)
    }
}
