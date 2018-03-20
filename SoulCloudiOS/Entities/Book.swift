//
//  Book.swift
//  SoulCloudiOS
//
//  Created by Damir Zaripov on 20.03.2018.
//  Copyright © 2018 BLVCK. All rights reserved.
//

import UIKit
import Foundation

struct Book: Codable {
    let id: Int
    let name: String
    let author: String
    let description: String
    let mark: Bool
    //let image: UIImage?
    
}
