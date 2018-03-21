//
//  ViewControllerInitiateExtension.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 19/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboards) -> Self {
        
        return appStoryboard.viewController(viewControllerClass: self)
    }
}


