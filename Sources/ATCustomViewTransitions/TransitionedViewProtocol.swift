//
//  TransitionedViewProtocol.swift
//
//  Created by Avi Tsadok on 28/12/2020.
//

import Foundation
import UIKit

protocol TransitionedViewProtocol {
    /**
     PreferredViewSize is the size the view will prefer to be. The transition code can consider this during animation.
     
     */
    var preferredViewSize : CGSize { get }
}
