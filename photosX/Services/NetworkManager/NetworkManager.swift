//
//  NetworkManager.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import Foundation

protocol NetworkManager {
    func request<T: Decodable>(url: URL,
                               httMethod: HttpMethods,
                               httpHeaders: [String: String]?,
                               httpBody: Encodable?,
                               completion: @escaping (Result<T, Error>) -> Void)
}

extension NetworkManager {
    func request<T: Decodable>(url: URL,
                               httMethod: HttpMethods = .get,
                               httpHeaders: [String: String]? = nil,
                               httpBody: Encodable? = nil,
                               completion: @escaping (Result<T, Error>) -> Void) {
        request(url: url, httMethod: .get, httpHeaders: nil, httpBody: nil, completion: completion)
    }
}

// MARK: - HttpMethods
enum HttpMethods: String {
    case get
    case post
    
    var value: String {
        self.rawValue.uppercased()
    }
}

// MARK: - HttpErrors

enum HttpErrors: Error {
    case invalidResponse
    case invalidStatusCode(Int)
    case dataNotFound
}
