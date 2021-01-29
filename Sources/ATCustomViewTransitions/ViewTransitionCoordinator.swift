//
//  ViewTransitionCoordinator.swift
//
//  Created by Avi Tsadok on 20/12/2020.
//

import Foundation
import UIKit


class ViewTransitionCoordinator {
    
    private var presentedViews = [UIView : ViewTransitionDelegate]()
    static let shared = ViewTransitionCoordinator()
    
    internal func register(_ presentedView : UIView, transitionDelegate : ViewTransitionDelegate) {
        
        presentedViews[presentedView] = transitionDelegate
    }
    
    internal func dismissView(view : UIView, completion : @escaping ()->Void) {
        guard let transitionDelegate = presentedViews[view] else {
            return
        }
        
        transitionDelegate.animateTransitionDismiss {[unowned self] in
            
            self.presentedViews.removeValue(forKey: view)
            completion()
        }
        
    }
    
}
