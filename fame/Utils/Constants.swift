//
//  APIPath.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation
import LocalAuthentication
import UIKit
import KeychainSwift

enum BiometricType {
    case none
    case touch
    case face
}

struct Constants {
    
    /// Ссылки на API
    struct Urls {
        static let kBaseUrl: String = {
                return "https://search-maps.yandex.ru/"
        }()
    }
    /// Информация об устройстве
    struct Device {
        private static let kUUIDKey = "UUID"
        
        /// UUID устройства
        static var kUUID: String {
            get {
                if let uuid = Constants.restoreValue(forKey: Constants.Device.kUUIDKey) as? String {
                    return uuid
                } else {
                    let uuid = UIDevice.current.identifierForVendor!.uuidString
                    Constants.save(value: uuid, forKey: Constants.Device.kUUIDKey)
                    return uuid
                }
            }
        }
        
        /// Имя устройства
        static let kName = UIDevice.current.name
    }
    
    struct Map {
        static let kAtms = ""
        static let kAtmsOne = "atms/one"
        static let kSettingsSanktion = "settings"
    }
    
    static func save(value: Any?, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    static func restoreValue(forKey: String) -> Any? {
        return UserDefaults.standard.value(forKey: forKey)
    }
    
    static var kBiometricType: BiometricType {
        var error: NSError?
        let authContext = LAContext()
        if #available(iOS 11.0, *) {
            if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
               // let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
                switch(authContext.biometryType) {
                case .none:
                    return .none
                case .touchID:
                    return .touch
                case .faceID:
                    return .face
                }
            } else {
                return .none
            }
        } else {
            if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
            } else {
                return .none
            }
//            return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
        }
    }
}
