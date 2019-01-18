//
//  VehicleRepresentation.swift
//  CarBooking
//
//  Created by De MicheliStefano on 18.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation

/**
 A vehicle representation model which represents a vehicle parsed from a JSON object.
 */

struct VehicleRepresentation: Codable {
    
    let identifier: Int16
    let name: String
    let shortDescript: String?
    let descript: String
    let image: String
    
}
