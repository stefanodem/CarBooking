//
//  VehicleController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 20.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

/**
 The model controller handling loading and saving data for vehicles.
 */

class VehicleController: NetworkService {
    
    // MARK: - Properties
    let baseUrl = URL(string: "http://job-applicants-dummy-api.kupferwerk.net.s3.amazonaws.com/api/")!
    
    // MARK: - Public    
    func load(completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        let url = self.url(with: baseUrl, pathComponents: ["cars"], pathExtension: "json")
        fetch(from: url, completion: completion)
    }
    
    func loadDetail(for vehicleId: Int16, completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        let url = self.url(with: baseUrl, pathComponents: ["cars", String(vehicleId)], pathExtension: "json")
        fetch(from: url, completion: completion)
    }
    
}
