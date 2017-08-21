//
//  UIAlertController+ex.swift
//  RSSAgent
//
//  Created by shock on 2017. 4. 14..
//  Copyright © 2017년 shock. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
    // 메세지를 알려주고 지정된 시간 후에 삭제
    class func tost(_ controller: UIViewController, title: String, second: Double = 1.2, completed: (() -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + second) {
            alert.dismiss(animated: true)
            if completed != nil {
                completed!()
            }
        }
    }
    
    // 확인 얼럿
    class func alert(_ controller: UIViewController, title: String, message: String?, completed: (() -> Void)? = nil)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Done".localized, style: .default) { action in
            alert.dismiss(animated: true)
            if completed != nil {
                completed!()
            }
        })
        
        controller.present(alert, animated: true)
    }
    
    // 확인/취소 얼럿
    class func confirm(_ controller: UIViewController, title: String, message: String?,
                       completed: @escaping (_ isOK: Bool) -> Void)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel) { action in
            alert.dismiss(animated: true)
            completed(false)
        })
        
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default) { action in
            alert.dismiss(animated: true)
            completed(true)
        })
        
        controller.present(alert, animated: true)
    }
    
    // 선택 얼럿
    class func select(_ controller: UIViewController, title: String, message: String,
                      firstButton: String, secondButton: String,
                      completed: @escaping (_ selectedButton: String) -> Void)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: firstButton, style: .cancel) { action in
            alert.dismiss(animated: true)
            completed(firstButton)
        })
        
        alert.addAction(UIAlertAction(title: secondButton, style: .default) { action in
            alert.dismiss(animated: true)
            completed(secondButton)
        })
        
        controller.present(alert, animated: true)
    }
    
    // 입력값 얼럿
    class func input(_ controller: UIViewController, title: String, message: String?,
                     defaultText: String?, placeHolder: String?, isSecure: Bool?,
                     completed: @escaping (_ resultText: String?) -> Void)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.text = defaultText ?? ""
            textField.placeholder = placeHolder ?? ""
            textField.isSecureTextEntry = isSecure ?? false
            textField.clearButtonMode = .whileEditing
            textField.autocapitalizationType = .words
        }
        
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel) { action in
            alert.dismiss(animated: true)
            completed(nil)
        })
        
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default) { action in
            alert.dismiss(animated: true)
            completed(alert.textFields!.first!.text ?? "")
        })
        
        controller.present(alert, animated: true)
    }
    
    // 로딩 얼럿
    @discardableResult
    class func loading(_ controller: UIViewController,
                       loadingStyle: UIActivityIndicatorViewStyle,
                       title: String? = "Loading".localized,
                       completed: ((_ alert: UIAlertController) -> Void)?) -> UIAlertController
    {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addLoadingView(loadingStyle: loadingStyle)
        
        controller.present(alert, animated: true) {
            if let result = completed {
                result(alert)
            }
        }
        
        return alert
    }
    
    // 프로그래스 얼럿
    class func progress(_ controller: UIViewController,
                        loadingStyle: UIActivityIndicatorViewStyle,
                        progressTint: UIColor,
                        title: String? = "Loading".localized,
                        completed: @escaping (_ alert: UIAlertController, _ progressView: UIProgressView) -> Void)
    {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addLoadingView(loadingStyle: loadingStyle)
        
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: 200, height: 10))
        progressView.tintColor = progressTint
        alert.view.addSubview(progressView)
        progressView.center = CGPoint(x: alert.view.bounds.midX, y: 50)
        
        alert.view.addConstraint(NSLayoutConstraint(
            item: progressView, attribute: .centerX, relatedBy: .equal,
            toItem: alert.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        controller.present(alert, animated: true) {
            completed(alert, progressView)
        }
    }
    
    func loadingDone(newTitle: String, completed: (() -> Void)? = nil) {
        if let activityIndicator = self.view.viewWithTag(999) {
            activityIndicator.removeFromSuperview()
        }
        self.title = newTitle
        
        self.addAction(UIAlertAction(title: "Done".localized, style: .default) { action in
            self.dismiss(animated: true)
            if completed != nil {
                completed!()
            }
        })
    }
}

fileprivate extension UIAlertController {
    // 로딩 뷰를 추가해 준다
    func addLoadingView(loadingStyle: UIActivityIndicatorViewStyle) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: loadingStyle)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.tag = 999
        self.view.addSubview(activityIndicator)
        
        let xConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal,
                                             toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal,
                                             toItem: self.view, attribute: .centerY, multiplier: 1.4, constant: 0)
        NSLayoutConstraint.activate([ xConstraint, yConstraint])
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        let height: NSLayoutConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.height,
                                                            relatedBy: NSLayoutRelation.equal,
                                                            toItem: nil, attribute: NSLayoutAttribute.notAnAttribute,
                                                            multiplier: 1, constant: 100)
        self.view.addConstraint(height)
    }
}




