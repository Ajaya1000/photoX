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
        showHome()
        window.makeKeyAndVisible()
    }
}

private extension AppCoordinator {
    func showHome() {
        self.removeChildCoordinators()
        
        let homeCoordinator = AppDelegate.container.resolve(HomeCoordinator.self)!
        homeCoordinator.navigationController = BaseNavigationController()
        
        self.start(coordinator: homeCoordinator)
        
        window.rootViewController = homeCoordinator.navigationController
    }
}
