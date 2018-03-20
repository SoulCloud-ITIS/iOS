//
//  AlertFactory.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 20/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import UIKit

class AlertFactory: AlertFactoryProtocol {
    
    func getAlert(with title: String, and message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
}
