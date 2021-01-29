//
//  ViewTransitionDelegate.swift
//
//  Created by Avi Tsadok on 20/12/2020.
//

import Foundation
import UIKit

public protocol ViewTransitionDelegate : class {
    
    /**
    The transition duration.
     
     - Retrun: Time interval
     */
    var transitionDuration : TimeInterval { get }
    
    /**
    Do the animation code here:
     
     - Parameter baseView: The container view the animation presetned from (usually View Controller)
     - Parameter fromView: The view animation started from (For example, a button)
     - Parameter presentedView: The view that supposed to be presented.
     */
    func animateTransition(baseView : UIView, fromView : UIView?,  presentedView : UIView)
    
    /**
    Do the dismissal animation code.
     
     - Parameter completion: Code that runs after the animation complete

     */
    func animateTransitionDismiss(completion : @escaping ()->Void)
    
}
