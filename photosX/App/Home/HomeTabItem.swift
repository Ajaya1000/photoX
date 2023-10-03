//
//  HomeTabItem.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import Foundation
import UIKit

enum HomeTabItem: Int, CaseIterable {
    case gallery = 0
    case library
}

extension HomeTabItem {
    var title: String {
        switch self {
        case .gallery:
            return "Gallery"
        case .library:
            return "Libary"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .gallery:
            return UIImage(systemName: "photo.artframe")
        case .library:
            return UIImage(systemName: "books.vertical.fill")
        }
    }
}
