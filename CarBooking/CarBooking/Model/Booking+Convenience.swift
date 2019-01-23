//
//  Booking+Convenience.swift
//  CarBooking
//
//  Created by De MicheliStefano on 18.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation
import CoreData

/**
 A booking model which represents a booking of a vehicle.
 */

extension Booking {
    
    convenience init(identifier: String = NSUUID().uuidString, startDate: Date, endDate: Date, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.identifier = identifier
        self.startDate = startDate
        self.endDate = endDate
    }
    
}
