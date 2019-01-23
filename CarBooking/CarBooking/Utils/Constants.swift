//
//  Constants.swift
//  CarBooking
//
//  Created by De MicheliStefano on 21.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

/**
 A constants file storing different types of constants used throughout the app.
 */

class Constants {
    // URLs
    static let vehicleBaseUrl = URL(string: "http://job-applicants-dummy-api.kupferwerk.net.s3.amazonaws.com/api/")!
    static let bookingBaseUrl = URL(string: "http://job-applicants-dummy-api.kupferwerk.net.s3.amazonaws.com/api/")!
    
    // Images
    static let placeholderImage = UIImage(named: "imagePlaceholder")!
    
    // UI
    static let titleFontSize: CGFloat = 20
    static let textFontSize: CGFloat = 14
    static let defaultPadding: CGFloat = 17
    static let defaultSpacing: CGFloat = 17
    
}
