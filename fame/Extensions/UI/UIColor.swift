//
//  UIColor.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF)
    }
    
    static let mariGold = UIColor(red: 255, green: 204, blue: 0)
    static let mariGold2 = UIColor(red: 255, green: 196, blue: 0)
    static let yellowOrange = UIColor(red: 242, green: 176, blue: 0)
    static let paleGrey = UIColor(red: 239, green: 240, blue: 242)
    static let paleGrey2 = UIColor(red: 235, green: 242, blue: 255)
    static let peacockBlue = UIColor(red: 0, green: 79, blue: 159)
    static let neonRed = UIColor(red: 248, green: 21, blue: 62)
    static let neonRedLight = UIColor(red: 252, green: 161, blue: 178)
    static let algaeGreen = UIColor(red: 34, green: 203, blue: 85)
    static let lighterPurple = UIColor(red: 148, green: 75, blue: 255)
    static let lightBlueGrey = UIColor(red: 204, green: 210, blue: 217)
    static let lightPeriwinkle = UIColor(red: 192, green: 213, blue: 253)
    static let lightPeriwinkle2 = UIColor(red: 214, green: 214, blue: 215)
    static let azure = UIColor(red: 11, green: 143, blue: 255)
    static let azure2 = UIColor(red: 11, green: 187, blue: 239)
    static let electricBlue = UIColor(red: 0, green: 88, blue: 255)
    static let darkElectricBlue = UIColor(red: 0, green: 56, blue: 206)
    static let blueGrey = UIColor(red: 128, green: 167, blue: 207)
    static let darkBlueGrey = UIColor(red: 177, green: 177, blue: 177)
    static let carnation = UIColor(red: 255, green: 113, blue: 139)
    static let brownGrey = UIColor(red: 172, green: 172, blue: 172)
    static let lightOrange = UIColor(red: 254, green: 204, blue: 0)
    static let lightGray = UIColor(red: 99, green: 100, blue: 102)
    static let blackShadowEffect = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.5)
    static let borderGray = UIColor(red: 229, green: 229, blue: 229)
    
    static let margiGold = UIColor(red: 255, green: 204, blue: 0)
    static let peacockBlueAlpha = UIColor(red: 0/255.0, green: 79/255.0, blue: 159/255.0, alpha: 0.49)
    static let chartLineGray = UIColor(red: 220, green: 223, blue: 231)
    static let tabBarGray = UIColor(red: 194, green: 193, blue: 193)
    static let fameGray = UIColor(red: 225, green: 225, blue: 232)
    static let fameGrayButton = UIColor(red: 245, green: 245, blue: 245)
    static let fameGrayButtonText = UIColor(red: 150, green: 150, blue: 150)
    static let fameGrayButtonActive = UIColor(red: 118, green: 78, blue: 208)
    
    static let goodPlace = UIColor(red: 0, green: 188, blue: 32, alpha: 0.25)
    static let badPlace = UIColor(red: 118, green: 78, blue: 208)
}
