//
//  BookingRepresentation.swift
//  CarBooking
//
//  Created by De MicheliStefano on 23.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

/**
 A booking representation model which represents a vehicle parsed from a JSON object.
 */

struct BookingRepresentation: Codable {
    
    let identifier: String
    let startDate: Date
    let endDate: Date
    
    enum CodingKeys: String, CodingKey {
        case identifier, startDate, endDate
    }
    
}
