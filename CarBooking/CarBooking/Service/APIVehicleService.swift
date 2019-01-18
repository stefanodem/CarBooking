//
//  APIVehicleService.swift
//  CarBooking
//
//  Created by De MicheliStefano on 18.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

/**
 The API service handling network requests for vehicles.
 */

class APIVehicleService: APIBaseService {
    
    // MARK: - Properties
    let baseUrl = URL(string: "http://job-applicants-dummy-api.kupferwerk.net.s3.amazonaws.com/api/")!
    
    // MARK: - Network requests
    func fetchVehicles(completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        let url = self.url(with: baseUrl, pathComponents: ["cars"])
        fetch(from: url, completion: completion)
    }
    
}
