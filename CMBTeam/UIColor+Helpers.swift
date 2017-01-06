//
//  UIColor+Helpers.swift
//  CMBTeam
//
//  Created by Dan Kindler on 1/5/16.
//  Copyright © 2016 hmu. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     Construct a UIColor using an HTML/CSS RGB formatted value and an alpha value
     - parameter rgbValue: RGB value
     - parameter alpha: color alpha value
     - returns: an UIColor instance that represent the required color
     */
    class func colorWithRGB(rgbValue: UInt, alpha: CGFloat = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255
        let green = CGFloat((rgbValue & 0xFF00) >> 8) / 255
        let blue = CGFloat(rgbValue & 0xFF) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
