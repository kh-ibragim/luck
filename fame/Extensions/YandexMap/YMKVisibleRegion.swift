//
//  YMKVisibleRegion.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation
import YandexMapKit

extension YMKVisibleRegion {
    
    var json: String {
        get {
            let latDelta = self.topRight.latitude - self.bottomRight.latitude
            let lonDelta = self.topRight.longitude - self.topLeft.longitude
            let cLat = self.topRight.latitude - latDelta/2
            let cLon = self.topRight.longitude - lonDelta/2
            return String(format: "[%.7f, %.7f, %.1f]", cLat, cLon, latDelta * 111 / 2)
        }
    }
    var centerLatitude: String {
        get {
            let latDelta = self.topRight.latitude - self.bottomRight.latitude
            let cLat = self.topRight.latitude - latDelta/2
            return String(cLat)
        }
    }
    var centerLongitude: String {
        get {
            let lonDelta = self.topRight.longitude - self.topLeft.longitude
            let cLon = self.topRight.longitude - lonDelta/2
            return String(cLon)
        }
    }
}

extension UserDefaults {
    
    func setCamera(_ camera: YMKCameraPosition?, forKey key: String) {
        if let trueCamera = camera {
            self.setValue(trueCamera.target.latitude, forKey: key + "latitude")
            self.setValue(trueCamera.target.longitude, forKey: key + "longitude")
            self.setValue(trueCamera.zoom, forKey: key + "zoom")
            self.synchronize()
        } else {
            self.setValue(nil, forKey: key + "latitude")
            self.setValue(nil, forKey: key + "longitude")
            self.setValue(nil, forKey: key + "zoom")
            self.synchronize()
        }
    }
    
    func camera(forKey key: String) -> YMKCameraPosition? {
        if let latitude = self.value(forKey: key + "latitude") as? Double,
            let longitude = self.value(forKey: key + "longitude") as? Double,
            let zoom = self.value(forKey: key + "zoom") as? Float {
            return YMKCameraPosition(target: YMKPoint(latitude: latitude, longitude: longitude), zoom: zoom, azimuth: 0, tilt: 0)
        } else {
            return nil
        }
    }
}


