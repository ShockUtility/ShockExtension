//
//  TestAlertViewController.swift
//  ShockExtension
//
//  Created by shock on 2017. 5. 6..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import UIKit
import StoreKit
import ShockExtension

class TestAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onClickBarButton(_ sender: UIBarButtonItem) {
        UIActivityViewController(self, barButtonItem: sender, url: URL(string: "http://www.google.com")!)        
    }
    
    @IBAction func onClickLikeToast(_ sender: Any) {
        UIAlertController.tost(self, title: "Toast Alert", second: 3.0)        
    }

    @IBAction func onClickNormal(_ sender: Any) {
        UIAlertController.alert(self, title: "Message Alert", message: "UIAlertController.alert") {
            print("Message Alert : Completed")
        }
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        UIAlertController.confirm(self, title: "Confirm Alert", message: "UIAlertController.confirm") { (isOK) in
            print("Confirm Alert :", isOK)
        }
    }
    
    @IBAction func onClickInput(_ sender: Any) {
        UIAlertController.input(self, title: "Input Alert", message: "UIAlertController.input", defaultText: "defaultText", placeHolder: "placeHolder", isSecure: false) { (resultText) in
            print("input : ", resultText ?? "null")
        }
    }
    
    @IBAction func onClickLoading(_ sender: Any) {
//        UIAlertController.loading(self, loadingStyle: .gray) { (alert) in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                alert.dismiss(animated: true, completion: nil)
//            }
//        }
        
        UIAlertController.loading(self,
                                  loadingStyle: .gray,
                                  title: "접속 중",
                                  cancelTitle: "취소",
                                  completed: { (alert) in
                                    print("loading completed")
                                  },
                                  canceled: {
                                    print("canceled")
                                  })
    }
    
    @IBAction func onClickProgress(_ sender: Any) {
        UIAlertController.progress(self, loadingStyle: .gray, progressTint: .red) { (alert, progressView) in
            for i in 1...10 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) / 10, execute: {
                    progressView.progress = Float(CGFloat(i) / 10.0)
                    if i == 10 {
                        alert.dismiss(animated: true)
                    }
                })
            }
        }
    }
    
    @IBAction func onClickSKStoreProduct(_ sender: Any) {
        SKStoreProductViewController.show(self, productID: "385048753")
    }
}






