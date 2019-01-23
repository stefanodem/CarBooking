//
//  MockDataLoader.swift
//  CarBooking
//
//  Created by De MicheliStefano on 23.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

class MockLoader: NetworkDataLoader {
    
    init(data: Data?, error: Error?) {
        self.data = data
        self.error = error
    }
    
    let data: Data?
    let error: Error?
    private(set) var request: URLRequest? = nil
    private(set) var url: URL? = nil
    
    
    func loadData(from request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.request = request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion(self.data, nil, self.error)
        }
    }
    
    func loadData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.url = url
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            completion(self.data, nil, self.error)
        }
    }
    
}
