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
        UIAlertController(self, title: "Toast Alert", second: 3.0)
    }

    @IBAction func onClickNormal(_ sender: Any) {
        UIAlertController(self, title: "Message Alert", message: "message", completedOK: {
            print("Message Alert : Completed")
        })
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        UIAlertController(self, title: "Confirm Alert", message: "message", completedOK: {
            print("Confirm Alert : OK")
        })
    }
    
    @IBAction func onClickInput(_ sender: Any) {
        UIAlertController(self, title: "Input",
                          message: "message",
                          defaultText: "default text",
                          placeHolder: "place holder", completed: { (isOK, text) in
            print("OK 버튼 클릭 =", isOK, " , 입력값 =", text)
        })
    }
    
    @IBAction func onClickLoading(_ sender: Any) {
        let loading = UIAlertController(self, loadingStyle: .gray)
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            loading.dismiss(animated: true)
        }
    }
    
    @IBAction func onClickProgress(_ sender: Any) {
        UIAlertController(self, loadingStyle: .gray, progressTint: .red) { (alert, progressView) in
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
}






