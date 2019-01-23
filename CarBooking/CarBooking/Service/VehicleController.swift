//
//  VehicleController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 20.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

/**
 The model controller for handling loading and saving data for vehicles.
 */

class VehicleController {
    
    // MARK: - Properties
    /// A generic network service that handles http requests.
    let networkService: NetworkService
    
    // MARK: - Init
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Public
    /// Loads vehicles from the network.
    func load(completion: @escaping (Response<[VehicleRepresentation]>) -> ()) {
        let url = networkService.url(pathComponents: ["cars"], pathExtension: "json")
        networkService.fetch(from: url, completion: completion)
    }
    
    /// Loads vehicle details from the network.
    func loadDetail(for vehicleId: Int16, completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        let url = networkService.url(pathComponents: ["cars", String(vehicleId)], pathExtension: "json")
        networkService.fetch(from: url, completion: completion)
    }
    
}
