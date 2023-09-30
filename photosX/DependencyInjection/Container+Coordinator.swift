//
//  Container+Coordinator.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import Foundation
import Swinject

extension Container {
    func registerCoordinator() {
        self.register(AppCoordinator.self) { _, window in
            AppCoordinator(window: window)
        }
        
        self.autoregister(HomeCoordinator.self, initializer: HomeCoordinator.init)
    }
}
