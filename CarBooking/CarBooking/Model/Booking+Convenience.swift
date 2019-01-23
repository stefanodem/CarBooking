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
    // TODO: Move to helper class
    /// The default date set to next day at 9am
    var defaultStartDate: Date {
        let calendar = Calendar.current
        let defaultStartTime = Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: Date())!
        let today = calendar.date(byAdding: .day, value: 1, to: defaultStartTime)!
        return calendar.date(bySetting: .hour, value: 9, of: today)!
    }
    
}
