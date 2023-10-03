//
//  Array+Extension.swift
//  photosX
//
//  Created by Ajaya Mati on 03/10/23.
//

import Foundation

extension Array {
    func slices(of size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min(count, $0 + size)])
        }
    }
}
