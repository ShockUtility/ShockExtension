//
//  SKStoreProductViewController+ex.swift
//  Pods
//
//  Created by shock on 2017. 8. 6..
//
//

import Foundation
import StoreKit

public extension SKStoreProductViewController {

    // 알리고 사라짐
    @discardableResult
    convenience init(_ controller: UIViewController, productID: String)
    {
        self.init()
        
        let alert = UIAlertController(title: "Loading...", message: nil, preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        alert.view.addSubview(activityIndicator)
        
        let xConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal,
                                             toItem: alert.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal,
                                             toItem: alert.view, attribute: .centerY, multiplier: 1.4, constant: 0)
        NSLayoutConstraint.activate([ xConstraint, yConstraint])
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: NSLayoutAttribute.height,
                                                            relatedBy: NSLayoutRelation.equal,
                                                            toItem: nil, attribute: NSLayoutAttribute.notAnAttribute,
                                                            multiplier: 1, constant: 100)
        alert.view.addConstraint(height)
        
        controller.present(alert, animated: true) {
            let storeViewController = SKStoreProductViewController()
            let parameters = [SKStoreProductParameterITunesItemIdentifier : productID]
            storeViewController.loadProduct(withParameters: parameters, completionBlock: { (loaded, error) in
                alert.dismiss(animated: true, completion: {
                    if loaded {
                        self.delegate = controller as? SKStoreProductViewControllerDelegate
                        self.present(storeViewController, animated: true, completion: nil)
//                        controller.navigationController?.pushViewController(storeViewController, animated: true) // iOS8 에서 오류 
                    }
                })
            })
        }
    }
    
}
