//
//  AppCoordinator.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        self.navigationController = BaseNavigationController()
        window.makeKeyAndVisible()
        window.rootViewController = self.navigationController
        
        showHome()
    }
}

private extension AppCoordinator {
    func showHome() {
        self.removeChildCoordinators()
        
        let homeCoordinator = AppDelegate.container.resolve(HomeCoordinator.self)!
        homeCoordinator.navigationController = self.navigationController
        
        self.start(coordinator: homeCoordinator)
    }
}
