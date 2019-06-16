//
//  MapFilterManager.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit

class MapFilterManager {
    
    static let sharedManager = MapFilterManager()
    var needRequest = false
    
    var entertainment: PriorCategory = .null
    var education: PriorCategory = .null
    var medicine: PriorCategory = .null
    var car: PriorCategory = .null
    var shop: PriorCategory = .null
    var traffic: PriorCategory = .null
    var bus: PriorCategory = .null
    var logistic: PriorCategory = .null
    
    init() {
    }
    
    
    
    func saveUserGeoposition(latitude: Float, longitude: Float) {
        UserDefaults.standard.set(latitude, forKey: "userLatitude")
        UserDefaults.standard.set(longitude, forKey: "userLongitude")
    }
    
    func getUserGeoposition() -> (latitude: Float?, longitude: Float?) {
        let latitude = UserDefaults.standard.value(forKey: "userLatitude") as? Float
        let longitude = UserDefaults.standard.value(forKey: "userLongitude") as? Float
        if latitude == nil || longitude == nil {
            return (45.021252, 38.965351)
        } else {
            return (latitude, longitude)
        }
    }

}

