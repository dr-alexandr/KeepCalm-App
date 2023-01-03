//
//  NetworkLayer.swift
//  KeepCalm
//
//  Created by Dr.Alexandr on 28.12.2022.
//

import Foundation
import MapKit

protocol NetworkManagerProtocol {
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)
    var task: URLSessionDataTask? { get set }
}

final class NetworkManager: NetworkManagerProtocol {
    
    var task: URLSessionDataTask?
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        task = session.dataTask(with: urlRequest) {
            data, response, error in
            if let error = error {
                completion(.failure(error))
                print("Unknown error: \(error)")
                return
            }
            guard response != nil, let data = data else {
                return
            }
            if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } else {
                let error = NSError(domain: "com.dr.alexandr",
                                    code: 200,
                                    userInfo: [NSLocalizedDescriptionKey: "Failed"])
                completion(.failure(error))
            }
        }
        task?.resume()
    }
}
