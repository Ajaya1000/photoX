//
//  Container+Services.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import Foundation
import Swinject
import SwinjectAutoregistration

extension Container {
    func registerServices() {
        self.autoregister(NetworkManager.self, initializer: NetworkManagerImpl.init).inObjectScope(.container)
    }
}
