//
//  PopupViewTransition.swift
//
//  Created by Avi Tsadok on 20/12/2020.
//

import Foundation
import UIKit


public class PopupViewTransition {
    
    var canTapOutsidePopup = true
    lazy fileprivate var darkView = UIView()
    var presentedView : UIView?
    fileprivate var fromView : UIView?
    
    public init() {
        
    }
}

extension PopupViewTransition : ViewTransitionDelegate {
            
    public var transitionDuration: TimeInterval {
        return 0.4
    }
    
    public func animateTransition(baseView: UIView, fromView: UIView?, presentedView: UIView) {

        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        self.presentedView = presentedView
        self.fromView = fromView
        
        addDarkView(to: baseView)
        
        addPopup(popup: presentedView, to: baseView, fromView: fromView)
        
        updatePopupSizeToNormalSize(popup: presentedView)
        
        window.layoutIfNeeded()
        let targetCenter = presentedView.center
        updatePopupSizeToSmall(popup: presentedView, fromView: fromView)
        window.layoutIfNeeded()

        darkView.alpha = 0.0
        UIView.animate(withDuration: transitionDuration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1.0, options: .curveEaseOut) {
            presentedView.transform = CGAffineTransform.identity
            presentedView.center = targetCenter
            self.darkView.alpha = 0.5
        } completion: { (finish) in
            
        }

    }
    
    public func animateTransitionDismiss(completion : @escaping ()->Void) {
        
        guard let presentedView = presentedView else {
            return
        }
        
        UIView.animate(withDuration: transitionDuration) {
            self.updatePopupSizeToSmall(popup: presentedView, fromView: self.fromView)
            self.darkView.alpha = 0.0
        } completion: { (finish) in
            self.removeViews()
            completion()
        }
    }
    
    private func removeViews() {
        darkView.removeFromSuperview()
        presentedView?.removeFromSuperview()
    }
    

    private func addPopup(popup : UIView, to baseView : UIView, fromView : UIView?) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        window.addSubview(popup)
        
    }
    
    private func getFinalFrameCalculated()->CGRect {
        
        if let transitionedView = presentedView as? TransitionedViewProtocol {
            let prefferedViewSize = transitionedView.preferredViewSize
            if prefferedViewSize.height > 0 {
                var frame : CGRect = getMaxPossibleFrame()
                if prefferedViewSize.height < frame.size.height && prefferedViewSize.height > 0 {
                    frame.size.height = prefferedViewSize.height
                }
                
                return frame
            }

        }
        
        return getPreferredSize()
    }
    
    private func getPreferredSize()->CGRect {
        guard let window = UIApplication.shared.keyWindow else {
            return .zero
        }
        
        let x : CGFloat = 10
        let y : CGFloat = 60
        let width = window.frame.size.width - 20
        let height : CGFloat = 280
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func getMaxPossibleFrame()->CGRect {
        guard let window = UIApplication.shared.keyWindow else {
            return .zero
        }
        
        let x : CGFloat = 10
        let y : CGFloat = 60
        let width = window.frame.size.width - 20
        let height : CGFloat = window.frame.size.height - y * 2
        
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    
    private func updatePopupSizeToSmall(popup : UIView, fromView : UIView?) {
        popup.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        if let fromView = fromView {
            if let window = UIApplication.shared.keyWindow {
                let centerInWindow = window.convert(fromView.center, from: fromView)
                popup.center = centerInWindow
            }
        }
    }
    
    private func updatePopupSizeToNormalSize(popup : UIView) {
        popup.frame = getFinalFrameCalculated()
    }
    
    private func addDarkView(to baseView : UIView) {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        darkView.backgroundColor = .black
        darkView.alpha = 0.5
        
        window.addSubview(darkView)
        darkView.translatesAutoresizingMaskIntoConstraints = false
        darkView.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
        darkView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
        darkView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
        darkView.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(darkViewTapped))
        darkView.addGestureRecognizer(tapGesture)
        
        window.layoutIfNeeded()
    }
    
    @objc func darkViewTapped() {
        guard let presentedView = presentedView else {
            return
        }
        
        guard canTapOutsidePopup else {
            return
        }
        
        presentedView.dismissTransition {
            
        }
    }
    
}
