//
//  AlertFactoryProtocol.swift
//  SoulCloudiOS
//
//  Created by BLVCK on 20/03/2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import Foundation
import UIKit

protocol AlertFactoryProtocol {
    
    /// Получение алерта с сообщением ошибки
    ///
    /// - Parameter message: сообщение ошибки
    /// - Returns: готовый алерт
    func getAlert(with title: String, and message: String) -> UIAlertController
}
