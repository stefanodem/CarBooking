//
//  Vehicle+Convenience.swift
//  CarBooking
//
//  Created by De MicheliStefano on 18.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation
import CoreData

/**
 A vehicle model which represents a vehicle present in the car pool.
 */

extension Vehicle {
    
    convenience init(identifier: Int16, name: String, shortDescript: String?, descript: String, image: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.identifier = identifier
        self.name = name
        self.shortDescript = shortDescript
        self.descript = descript
        self.image = image
    }
    
    /// An initializer that initializes a Vehicle model from a parsed JSON object.
    convenience init?(vehicleRepresentation: VehicleRepresentation, context: NSManagedObjectContext) {
        self.init(identifier: vehicleRepresentation.identifier,
                  name: vehicleRepresentation.name,
                  shortDescript: vehicleRepresentation.shortDescript,
                  descript: vehicleRepresentation.descript,
                  image: vehicleRepresentation.image)
    }
    
}
