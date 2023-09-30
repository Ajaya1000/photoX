//
//  Container+RegisterDependencies.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import Foundation
import Swinject

extension Container {
    func registerDependencies(){
        self.registerServices()
        self.registerCoordinator()
    }
}
