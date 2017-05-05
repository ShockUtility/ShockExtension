//
//  UIAlertController+ex.swift
//  RSSAgent
//
//  Created by shock on 2017. 4. 14..
//  Copyright © 2017년 shock. All rights reserved.
//

import Foundation

public extension UIAlertController {
    
    // 알리고 사라짐
    @discardableResult
    convenience init(_ controller: UIViewController, title: String, second: Double = 0.7)
    {
        self.init(title: title, message: nil, preferredStyle: .alert)
        controller.present(self, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+second) {
            self.dismiss(animated: true)
        }
    }
    
    // 메세지 알림과 종료 핸들러
    @discardableResult
    convenience init(_ controller: UIViewController, title: String, message: String?,
                     completed: (() -> Void)? = nil)
    {
        self.init(title: title, message: message, preferredStyle: .alert)
        
        self.addAction(UIAlertAction(title: "Done".localized, style: .default) { action in
            if let com = completed {
                com()
            }
            self.dismiss(animated: true)
        })
        
        controller.present(self, animated: true)
    }
    
    // 확인/취소 선택 얼럿
    @discardableResult
    convenience init(_ controller: UIViewController, title: String, message: String?,
                     completedOK: @escaping () -> Void)
    {
        self.init(title: title, message: message, preferredStyle: .alert)
        
        self.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel) { action in
            self.dismiss(animated: true)
        })
        
        self.addAction(UIAlertAction(title: "OK".localized, style: .default) { action in
            completedOK()
            self.dismiss(animated: true)
        })
        
        controller.present(self, animated: true)
    }
    
    // 인풋박스 얼럿
    @discardableResult
    convenience init(_ controller: UIViewController, title: String, message: String?,
                     defaultText: String, placeHolder: String,
                     completed: @escaping (_ name: String) -> Void)
    {
        self.init(title: title, message: message, preferredStyle: .alert)
        
        self.addTextField { textField in
            textField.text = defaultText
            textField.placeholder = placeHolder
            textField.clearButtonMode = .whileEditing
            textField.autocapitalizationType = .words
        }
        
        self.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel) { action in
            self.dismiss(animated: true)
        })
        
        self.addAction(UIAlertAction(title: "OK".localized, style: .default) { action in
            if let name = self.textFields!.first!.text {
                let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                completed(trimmedName)
            }
            self.dismiss(animated: true)
        })
        
        controller.present(self, animated: true)
    }
    
    fileprivate convenience init(loadingStyle: UIActivityIndicatorViewStyle) {
        self.init(title: "Loading".localized, message: nil, preferredStyle: .alert)
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: loadingStyle)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
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
        self.view.addConstraint(height);
    }
    
    // 로딩 얼럿
    convenience init(_ controller: UIViewController, loadingStyle: UIActivityIndicatorViewStyle = .gray)
    {
        self.init(loadingStyle: loadingStyle)
        controller.present(self, animated: true)
    }
    
    // 프로그래스 얼럿
    @discardableResult
    convenience init(_ controller: UIViewController,
                     loadingStyle: UIActivityIndicatorViewStyle, progressTint: UIColor,
                     completed: @escaping (_ alert: UIAlertController, _ progressView: UIProgressView) -> Void)
    {
        self.init(loadingStyle: loadingStyle)
        
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: 200, height: 10))
        progressView.tintColor = progressTint
        self.view.addSubview(progressView)
        progressView.center = CGPoint(x: self.view.bounds.midX, y: 50)
        
        self.view.addConstraint(NSLayoutConstraint(
            item: progressView, attribute: .centerX, relatedBy: .equal,
            toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
        controller.present(self, animated: true) {
            completed(self, progressView)
        }
    }
}






