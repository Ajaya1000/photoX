//
//  HomeCoordinator.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import Foundation
import UIKit

class HomeCoordinator: BaseCoordinator {
    override func start() {
        let viewController = HomeViewController()
        
        self.navigationController.setViewControllers([viewController], animated: true)
    }
}
