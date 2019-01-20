//
//  UIColor+Extension.swift
//  CarBooking
//
//  Created by De MicheliStefano on 20.01.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import UIKit

extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    /// App colors
    static let primary = UIColor.rgb(red: 172, green: 207, blue: 204)
    static let secondary = UIColor.rgb(red: 89, green: 82, blue: 65)
    static let accent = UIColor.rgb(red: 138, green: 9, blue: 23)

}
