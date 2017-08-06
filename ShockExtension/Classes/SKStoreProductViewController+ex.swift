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

    // 앱스토어 창 띄우기
    class func show(_ controller: UIViewController, productID: String)
    {
        let store = SKStoreProductViewController.init()
        store.delegate = controller as? SKStoreProductViewControllerDelegate
        
        UIAlertController.loading(store, loadingStyle: .gray) { (loadingAlert) in
            let parameters = [SKStoreProductParameterITunesItemIdentifier : productID]
            store.loadProduct(withParameters: parameters, completionBlock: { (loaded, error) in
                loadingAlert.dismiss(animated: true, completion: {
                    if loaded {
                        controller.present(store, animated: true, completion: nil)
                    }
                })
            })
        }
    }
}


