//
//  API.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Alamofire
import AlamofireNetworkActivityIndicator
import LocalAuthentication
import Firebase

enum APIVersion: String {
    case SupportApi = "v1"
}

protocol APIController {
    static var sessionManager: DigestSessionManager { get }
}

struct API: APIController {
    static let sessionManager = DigestSessionManager.standard
    static var baseURLString: String = {
        NetworkActivityIndicatorManager.shared.isEnabled = true
        return Constants.Urls.kBaseUrl
    }()
    
    
    static func logout() {
        NonceManager.shared.cleanup(removePin: false)
      //  API.isAuth = false
    }
    
    static func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    static func putNonNilValues(_ values: [String: Any?], to params: inout [String: Any]) {
        for (key, value) in values {
            guard value != nil else { continue }
            params[key] = value
        }
    }
}

struct QError {
    static let domain: String = "com.ibragimkhasanov.fame"
    
    static func info(userInfo: [String: AnyObject]) -> NSError {
        return NSError(domain: self.domain, code: -1, userInfo: userInfo)
    }
    
    static func standard(reason: String) -> NSError {
        return NSError(domain: self.domain, code: -1, userInfo: [NSLocalizedDescriptionKey: reason])
    }
    
    static func standard(reason: String, code: Int) -> NSError {
        return NSError(domain: self.domain, code: code, userInfo: [NSLocalizedDescriptionKey: reason])
    }
    
    static var unknown: NSError {
        return NSError(domain: self.domain, code: -1, userInfo: [NSLocalizedDescriptionKey: "An Unknown Error Occurred"])
    }
    
    static var serialization: NSError {
        return NSError(domain: self.domain, code: -1, userInfo: [NSLocalizedDescriptionKey: "A Serialization Error Occurred"])
    }
}
