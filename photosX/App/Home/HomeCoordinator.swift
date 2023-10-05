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
        
        let viewControllers = getViewControllers()
        viewController.setup(with: viewControllers)
        
        
        let vc = getGalleryViewController()
        
        self.navigationController.setViewControllers([viewController, vc], animated: false)
    }
}

private extension HomeCoordinator {
    func getViewControllers() -> [UIViewController] {
        
        let tabItems = getTabItems()
        
        return tabItems.map { item in
            let vc: UIViewController
            
            switch item {
            case .gallery:
                vc = getGalleryViewController()
            case .library:
                vc = getLibaryViewController()
            }
            
            vc.tabBarItem = UITabBarItem(title: item.title, image: item.image, tag: item.rawValue)
            return vc
        }
    }
    
    func getTabItems() -> [HomeTabItem] {
        return [.library]
    }
}

private extension HomeCoordinator {
    func getGalleryViewController() -> UIViewController {
        let vc = AlbumsViewController(viewModel: AlbumViewModel())
        return vc
    }
    
    func getLibaryViewController() -> UIViewController {
        let vc = LibraryViewController()
        return vc;
    }
}
