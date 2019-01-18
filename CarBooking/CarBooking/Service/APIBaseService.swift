//
//  APIBaseService.swift
//  CarBooking
//
//  Created by De MicheliStefano on 18.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

/// A generic response type for handling network responses.
enum Response<Value> {
    case success(Value)
    case error(Error)
}

/// An HTTP method type for type-safe http method configurations.
enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case get = "GET"
    case delete = "DELETE"
}

/**
 A generic API base service for performing network calls.
 */

class APIBaseService {
    
    // MARK: - Properties & init
    
    /// A network loader property that provides ability for independency injection.
    let networkLoader: NetworkDataLoader
    
    init(networkLoader: NetworkDataLoader = URLSession.shared) {
        self.networkLoader = networkLoader
    }
    
    // MARK: - Generic network requests
    
    func url(with baseUrl: URL, pathComponents: [String]) -> URL {
        var url = baseUrl
        pathComponents.forEach { url.appendPathComponent($0) }
        return url
    }
    
    func fetch<Resource: Codable>(from url: URL, using session: URLSession = URLSession.shared, completion: @escaping ((Response<Resource>) -> ())) {
        networkLoader.loadData(from: url) { (data, res, error) in
            
            if let error = error {
                NSLog("Error with FETCH urlRequest: \(error)")
                completion(Response.error(error))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(Response.error(NSError(domain: "com.stefano.CarBooking.ErrorDomain", code: -1, userInfo: nil)))
                return
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    NSLog("An error code was returned from the http request: \(httpResponse.statusCode)")
                    completion(Response.error(NSError(domain: "com.stefano.CarBooking.ErrorDomain", code: -1, userInfo: nil)))
                    return
                }
            }
            
            do {
                let ressource = try JSONDecoder().decode(Resource.self, from: data)
                completion(Response.success(ressource))
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(Response.error(error))
                return
            }
        }
    }
    
    func put(with url: URL, requestBody: Dictionary<String, Any>, completion: @escaping (Response<String>) -> ()) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.put.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let requestBody = requestBody
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
        } catch {
            NSLog("Failed to encode foods: \(error)")
            completion(Response.error(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, res, error) in
            
            if let error = error {
                NSLog("Error with PUT urlRequest: \(error)")
                completion(Response.error(error))
                return
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    NSLog("An error code was returned from the http request: \(httpResponse.statusCode)")
                    completion(Response.error(NSError(domain: "com.stefano.CarBooking.ErrorDomain", code: -1, userInfo: nil)))
                    return
                }
            }
            completion(Response.success("Success"))
        }.resume()
    }
    
    func post<Resource: Codable>(with url: URL, requestBody: Dictionary<String, Any>, using session: URLSession = URLSession.shared, completion: @escaping ((Response<Resource>) -> ())) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let requestBody = requestBody
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted) //encoder.encode(requestBody)
            urlRequest.httpBody = jsonData
        } catch {
            NSLog("Failed to encode foods: \(error)")
            completion(Response.error(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, res, error) in
            
            if let error = error {
                NSLog("Error with POST urlRequest: \(error)")
                completion(Response.error(error))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                completion(Response.error(NSError(domain: "com.stefano.CarBooking.ErrorDomain", code: -1, userInfo: nil)))
                return
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    NSLog("An error code was returned from the http request: \(httpResponse.statusCode)")
                    completion(Response.error(NSError(domain: "com.stefano.CarBooking.ErrorDomain", code: -1, userInfo: nil)))
                    return
                }
            }
            
            do {
                let response = try JSONDecoder().decode(Resource.self, from: data)
                completion(Response.success(response))
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(Response.error(error))
                return
            }
        }.resume()
    }
    
    func delete(with url: URL, using session: URLSession = URLSession.shared, completion: @escaping ((Response<String>) -> ())) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.delete.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, res, error) in
            
            if let error = error {
                NSLog("Error with DELETE urlRequest: \(error)")
                completion(Response.error(error))
                return
            }
            
            if let httpResponse = res as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    NSLog("An error code was returned from the http request: \(httpResponse.statusCode)")
                    completion(Response.error(NSError(domain: "com.stefano.CarBooking.ErrorDomain", code: -1, userInfo: nil)))
                    return
                }
            }
            completion(Response.success("Success"))
        }.resume()
    }
    
}
