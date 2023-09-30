//
//  BaseNavigationController.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
    }
}
