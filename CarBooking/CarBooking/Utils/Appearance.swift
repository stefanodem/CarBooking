//
//  Appearance.swift
//  CarBooking
//
//  Created by De MicheliStefano on 23.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

/**
 An appearance enum that stores UI default information.
 */

enum Appearance {
    
    static let primary = UIColor.rgb(red: 172, green: 207, blue: 204)
    static let secondary = UIColor.rgb(red: 89, green: 82, blue: 65)
    static let accent = UIColor.rgb(red: 138, green: 9, blue: 23)
    static let correctGreen = UIColor.rgb(red: 76, green: 185, blue: 68)
    
    static func setupNavigation() {
        UINavigationBar.appearance().tintColor = accent
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = secondary
    }
    
    static func setupTabBar() {
        UITabBar.appearance().tintColor = accent
        UITabBar.appearance().barTintColor = secondary
    }
    
}
