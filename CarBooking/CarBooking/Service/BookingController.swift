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
    /// Loads all bookings from the network and syncs with the lcoal persistence store.
    func load(completion: @escaping (Response<VehicleRepresentation>) -> ()) {
        // Fetch bookings from network
        // Synchronize bookings with local persistence store
    }
    
    /// Saves a booking to local persistence and posts it to the web server.
    func book(_ vehicle: VehicleRepresentation, from startDate: Date, to endDate: Date, completion: @escaping (Response<Int>) -> ()) {
        // Save a booking to local persistence.
        let context = CoreDataStack.shared.mainContext
        context.perform {
            do {
                // Instatiate Core Data model objects for booking and vehicle.
                let booking = Booking(startDate: startDate, endDate: endDate)
                let vehicle = Vehicle(vehicleRepresentation: vehicle, context: context)
                // Add the vehicle that is associated with the booking.
                booking.vehicle = vehicle
                
                try CoreDataStack.shared.save(context: context)
            } catch {
                completion(Response.error(error))
                return
            }
        }
        
        // Post booking to the web server.
        post(from: startDate, to: endDate, completion: completion)
    }
    
    // MARK: - Network requests
    private func load(completion: @escaping (Response<[BookingRepresentation]>) -> ()) {
        let url = networkService.url(pathComponents: ["bookings"], pathExtension: "json")
        networkService.fetch(from: url, completion: completion)
    }
    
    private func post(from startDate: Date, to endDate: Date, completion: @escaping (Response<Int>) -> ()) {
        let url = networkService.url(pathComponents: ["bookings"], pathExtension: "json")
        let reqBody = ["startDate": startDate.timeIntervalSince1970, "endDate": endDate.timeIntervalSince1970]
        networkService.post(with: url, requestBody: reqBody, completion: completion)
    }
    
    // MARK: - Local persistence
    
    
}
