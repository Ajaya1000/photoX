//
//  NetworkManager.swift
//  photosX
//
//  Created by Ajaya Mati on 30/09/23.
//

import Foundation

class NetworkManagerImpl: NetworkManager {
    
    /// Request data from endpoint
    /// - Parameters:
    ///   - url: end point
    ///   - httMethod: http method
    ///   - completion: completion closure gets call after the request is complete with result of either the request type or error
    func request<T: Decodable>(url: URL,
                               httMethod: HttpMethods,
                               httpHeaders: [String: String]?,
                               httpBody: Encodable?,
                               completion: @escaping (Result<T, Error>) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httMethod.value
        
        if let httpHeaders {
            for (key, value) in httpHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if httMethod == .post,
           let httpBody {
            do {
                let data = try JSONEncoder().encode(httpBody)
                request.httpBody = data
            } catch {
                completion(.failure(error))
            }
        }
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            
            let completionOnMainThread: (Result<T, Error>) -> Void  = { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if let error = error {
                completionOnMainThread(.failure(error))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completionOnMainThread(.failure(HttpErrors.invalidResponse))
                return
            }
            
            guard (200..<300).contains(urlResponse.statusCode) else {
                completionOnMainThread(.failure(HttpErrors.invalidStatusCode(urlResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completionOnMainThread(.failure(HttpErrors.dataNotFound))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completionOnMainThread(.success(result))
            } catch {
                completionOnMainThread(.failure(error))
            }
        }
        
        // request is started
        urlSession.resume()
    }
}
