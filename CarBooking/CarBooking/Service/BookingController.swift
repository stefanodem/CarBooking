//
//  BookingController.swift
//  CarBooking
//
//  Created by De MicheliStefano on 20.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation
import CoreData

/**
 The model controller for handling loading and saving data for bookings.
 */

class BookingController {
    
    // MARK: - Properties
    /// A generic network service that handles http requests.
    let networkService: NetworkService
    
    // MARK: - Init
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Public
    /// Loads all bookings from the network and syncs with the local persistence store.
    func load(completion: @escaping (Response<[Booking]>) -> ()) {
        // Fetch bookings from network
        // TODO: Hook up to web server and then synchronize with local store.
        // Synchronize bookings with local persistence store
        let bookings = load()
        completion(Response.success(bookings))
        return
    }
    
    /// Saves a booking to local persistence and posts it to the web server.
    func book(_ vehicle: VehicleRepresentation, from startDate: Date, to endDate: Date, completion: @escaping (Response<Int>) -> ()) {
        // Save a booking to local persistence.
        do {
            try save(vehicle, from: startDate, to: endDate)
        } catch {
            completion(Response.error(error))
            return
        }
        
        // Post booking to the web server.
        post(from: startDate, to: endDate, completion: completion)
    }
    
    // MARK: - Network requests
    /// Loads bookings to network. Note: this is currently mocked via a mock loader passed in as the network service.
    private func load(completion: @escaping (Response<[BookingRepresentation]>) -> ()) {
        let url = networkService.url(pathComponents: ["bookings"], pathExtension: "json")
        networkService.fetch(from: url, completion: completion)
    }
    
    /// Posts booking to network. Note: this is currently mocked via a mock loader passed in as the network service.
    private func post(from startDate: Date, to endDate: Date, completion: @escaping (Response<Int>) -> ()) {
        let url = networkService.url(pathComponents: ["bookings"], pathExtension: "json")
        let reqBody = ["startDate": startDate.timeIntervalSince1970, "endDate": endDate.timeIntervalSince1970]
        networkService.post(with: url, requestBody: reqBody, completion: completion)
    }
    
    // MARK: - Local persistence
    /// Saves booking to local persistence.
    private func save(_ vehicleRep: VehicleRepresentation, from startDate: Date, to endDate: Date) throws {
        var error: Error?
        let context = CoreDataStack.shared.mainContext
        context.perform {
            do {
                // Instatiate Core Data model objects for booking and vehicle.
                let booking = Booking(startDate: startDate, endDate: endDate)
                let vehicle = Vehicle(vehicleRepresentation: vehicleRep, context: context)
                // Add the vehicle that is associated with the booking.
                booking.vehicle = vehicle
                
                try CoreDataStack.shared.save(context: context)
                
            } catch let saveError {
                error = saveError
            }
        }
        
        if let error = error { throw error }
    }
    
    /// Loads bookings from local persistence.
    private func load(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) -> [Booking] {
        var bookings = [Booking]()
        
        let fetchRequest = NSFetchRequest<Booking>(entityName: CoreDataEntities.Booking.rawValue)
        context.performAndWait {
            do {
                bookings = try context.fetch(fetchRequest)
            } catch {
                NSLog("Error fetching movie from persistent store: \(error)")
            }
        }
        
        return bookings
    }
    
}
