//
//  BookingController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 20.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

/**
 The model controller handling loading and saving data for bookings.
 */

class BookingController: NetworkService {
    
    // MARK: - Properties
    let baseUrl = URL(string: "http://job-applicants-dummy-api.kupferwerk.net.s3.amazonaws.com/api/")!
    
    // MARK: - Public
    
    func load(completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        // Fetch bookings from network
        // Synchronize bookings with local persistence store
    }
    
    // MARK: - Local persistence
    
    // MARK: - Network requests
    private func fetch(completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        let url = self.url(with: baseUrl, pathComponents: ["bookings"], pathExtension: "json")
        fetch(from: url, completion: completion)
    }
    
    private func fetchDetail(for bookingId: Int16, completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        let url = self.url(with: baseUrl, pathComponents: ["bookings", String(bookingId)], pathExtension: "json")
        fetch(from: url, completion: completion)
    }
    
}
