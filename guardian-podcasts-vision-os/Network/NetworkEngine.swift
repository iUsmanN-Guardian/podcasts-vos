//
//  NetworkEngine.swift
//  guardian-podcasts-vision-os
//
//  Created by Usman Nazir on 28/12/2023.
//

import Foundation
import Combine
import UIKit

protocol NetworkEngine {}

extension NetworkEngine {
    
    func networkRequest<T: Codable>(endpoint: Endpoint) async -> Result<T, AppError> {
        
        var components = URLComponents()

        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.host.rawValue
        components.path = endpoint.path.rawValue
        components.queryItems = endpoint.parameters?.map({ row in return URLQueryItem(name: row.key, value: row.value) })
        
        guard let url = components.url else {
            return .failure(.networkEngineFailure)
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        if endpoint.body != nil {
            let jsonBody = try? JSONSerialization.data(withJSONObject: endpoint.body as Any)
            urlRequest.httpBody = jsonBody
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else {
                print("Failed at \(endpoint.path), .networkResponseFailure")
                return .failure(.networkResponseFailure)
            }
            guard response.statusCode == 200 || response.statusCode == 201 else {
                print("Failed at \(endpoint.path), networkStatusCodeFailure")
                return .failure(.networkStatusCodeFailure)
            }
            guard let responseObject = try? JSONDecoder().decode(T.self, from: data) else {
                print("Failed at \(endpoint.path), networkDecodingFailure")
                print("Status: \(response.statusCode), URL: \(url), Data: \(String(decoding: data, as: UTF8.self))")
                return .failure(.networkDecodingFailure)
            }
            return.success(responseObject)
        } catch {
            print("Failed at \(endpoint.path), networkEngineFailure")
            return .failure(.networkEngineFailure)
        }
    }
}
