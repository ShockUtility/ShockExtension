//
//  UIBarButtonItem+ex.swift
//  Pods
//
//  Created by shock on 2017. 5. 6..
//
//

import UIKit

private var handle: UInt8 = 0;

public extension UIBarButtonItem {
    
    private var badgeLayer: CAShapeLayer? {
        if let b: AnyObject = objc_getAssociatedObject(self, &handle) as AnyObject? {
            return b as? CAShapeLayer
        } else {
            return nil
        }
    }
    
    var badgeValue:Int {
        get {
            return self.tag
        }
        set {
            self.tag = newValue
            badgeLayer?.removeFromSuperlayer()
            if newValue == 0 {
                return
            }
            updateBadge()
        }
    }
    
    private func updateBadge() {
        guard let view = self.value(forKey: "view") as? UIView else { return }
        
        let font = UIFont.systemFont(ofSize: 8)
        let badgeSize = badgeValue.description.size(attributes: [NSFontAttributeName: font])
        
        // Initialize Badge
        let badge = CAShapeLayer()
        let height = badgeSize.height;
        var width = badgeSize.width + 2
        
        //make sure we have at least a circle
        if (width < height) {
            width = height
        }
        
        //x position is offset from right-hand side
        let x = view.frame.width - width - 5
        let badgeFrame = CGRect(origin: CGPoint(x: x, y: 2), size: CGSize(width: width, height: height))
        badge.fillColor = UIColor.red.cgColor
        badge.strokeColor = UIColor.red.cgColor
        badge.path = UIBezierPath(roundedRect: badgeFrame, cornerRadius: 7).cgPath
        view.layer.addSublayer(badge)
        
        // Initialiaze Badge's label
        let label = CATextLayer()
        label.string = badgeValue.description
        label.alignmentMode = kCAAlignmentCenter
        label.font = font
        label.fontSize = 8
        label.frame = badgeFrame
        label.foregroundColor = UIColor.white.cgColor
        label.backgroundColor = UIColor.clear.cgColor
        label.contentsScale = UIScreen.main.scale
        badge.addSublayer(label)
        
        // 이게 없다면 badge의 서브 레이어가 계속 추가된다.
        objc_setAssociatedObject(self, &handle, badge, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
