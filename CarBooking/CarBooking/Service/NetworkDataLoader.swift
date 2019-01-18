//
//  NetworkDataLoader.swift
//  CarBooking
//
//  Created by De MicheliStefano on 18.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

/**
 A network data loader protocol and extension for loading data from network.
 */

protocol NetworkDataLoader {
    func loadData(from request: URLRequest, completion: @escaping(Data?, URLResponse?,  Error?) -> Void)
    func loadData(from url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkDataLoader {
    func loadData(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: request) { (data, res, error) in
            completion(data, res, error)
        }.resume()
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: url) { (data, res, error) in
            completion(data, res, error)
        }.resume()
    }
}
