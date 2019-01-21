//
//  BookingController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 20.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

/**
 The model controller for handling loading and saving data for bookings.
 */

class BookingController {
    
    // MARK: - Properties
    let networkService: NetworkService
    
    // MARK: - Init
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Public
    
    func load(completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        // Fetch bookings from network
        // Synchronize bookings with local persistence store
    }
    
    // MARK: - Local persistence
    
    // MARK: - Network requests
    private func fetch(completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        let url = networkService.url(pathComponents: ["bookings"], pathExtension: "json")
        networkService.fetch(from: url, completion: completion)
    }
    
    private func fetchDetail(for bookingId: Int16, completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        let url = networkService.url(pathComponents: ["bookings", String(bookingId)], pathExtension: "json")
        networkService.fetch(from: url, completion: completion)
    }
    
}
