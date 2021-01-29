//
//  UIView+ViewTransition.swift
//
//  Created by Avi Tsadok on 20/12/2020.
//

import Foundation
import UIKit

extension UIView {
    
    /**
    Present the view in animation on the sender view.
     
     - Parameter presentedView: The view being presented
     - Parameter fromView: The view animation started from (For example, a button)
     - Parameter transitionDelegate: The transition delegate that handles the animation
     */
    public func present(presentedView : UIView, fromView : UIView?, transitionDelegate : ViewTransitionDelegate) {
        transitionDelegate.animateTransition(baseView: self, fromView: fromView, presentedView: presentedView)
        ViewTransitionCoordinator.shared.register(presentedView, transitionDelegate: transitionDelegate)        
    }
    
    /**
    Dismiss the sender view, in case it was presented using this API
     
     - Parameter completion: Closure that will run at the end of the animation

     */
    public func dismissTransition(completion : @escaping ()->Void) {
        ViewTransitionCoordinator.shared.dismissView(view: self, completion: completion)
    }
}
