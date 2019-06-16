//
//  LocalManager.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit

/// SINGLETON
class NonceManager {
    static let shared = NonceManager()
    private var cnonce = ""
    private var nonce: String?
    private var salt: String?
    private var hashalg: String?
    private var realm: String?
    private var qop: String?
    private var username: String?
    private var password: String?
    private var nc = ""
    private var isPin = false
    private static var nc = 0
    
    private init() {
       // self.isPin = Constants.Auth.kPinCode != nil
    }
    
    public func set(username: String, password: String) {
        self.cleanup(removePin: false)
        self.username = username
        self.password = password
    }
    
    public func set(sysuser: String? = nil, pin: String?) {
//        Constants.Auth.kSysuser = sysuser ?? Constants.Auth.kSysuser
//        Constants.Auth.kPinCode = pin
//        self.isPin = self.password == nil ? pin != nil : false
    }
    
    public func getHeader(from uri: String?, _ method: String?) -> String? {
        let uri = uri ?? "", method = method ?? ""
        guard let response = self.getResponse(from: uri, method) else { return nil }
        let realm = self.realm ?? "", nonce = self.nonce ?? "", qop = self.qop ?? ""
        
//        if self.isPin {
//            let sysuser = Constants.Auth.kSysuser ?? ""
//            return "SPIN Digest sysuser=\"\(sysuser)\", realm=\"\(realm)\", nonce=\"\(nonce)\", uri=\"\(uri)\", response=\"\(response)\", qop=\"\(qop)\", nc=\"\(self.nc)\", cnonce=\"\(self.cnonce)\", deviceid=\"\(Constants.Device.kUUID)\", device_name=\"\(Constants.Device.kName)\""
//        } else {
//            let username = self.username!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
//            return "SP Digest username=\"\(username)\", realm=\"\(realm)\", nonce=\"\(nonce)\", uri=\"\(uri)\", response=\"\(response)\", qop=\"\(qop)\", nc=\"\(self.nc)\", cnonce=\"\(self.cnonce)\""
//        }
        return ""
    }
    
    public func getPingHeader() -> String {
//        if self.username != nil {
//             return self.isPin ? "SPIN Digest sysuser=\"\(Constants.Auth.kSysuser!)\", deviceid=\"\(Constants.Device.kUUID)\"" : "SP Digest username=\"\(self.username!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)\""
//        } else {
//             return self.isPin ? "SPIN Digest sysuser=\"\(Constants.Auth.kSysuser!)\", deviceid=\"\(Constants.Device.kUUID)\"" : "SP Digest username=\"\""
//        }
//
       return ""
    }
    
    public func parse(_ header: String?) {
        guard var _header = header else { return }
        var authHeader = [String: String]()
        _header = _header.replacingOccurrences(of: "SPIN Digest ", with: "").replacingOccurrences(of: "SP Digest ", with: "")
        let headerArr = _header.components(separatedBy: "\", ")
        for item in headerArr {
            let dict = item.components(separatedBy: "=\"")
            authHeader[dict.item(at: 0)] = dict.item(at: 1)
        }

        self.nonce = authHeader["nonce"]
        self.salt = authHeader["salt"]
        self.hashalg = authHeader["hashalg"]
        self.realm = authHeader["realm"]
        self.qop = authHeader["qop"]
    }
    
    public func updateNonce(from header: String?) {
        guard var _header = header else { return }
        _header = _header.replacingOccurrences(of: "SPIN Digest ", with: "").replacingOccurrences(of: "SP Digest ", with: "")
        let headerArr = _header.components(separatedBy: "\", ")
        for item in headerArr {
            let dict = item.components(separatedBy: "=\"")
            if dict.item(at: 0) == "nonce" {
                self.nonce = dict.item(at: 1)
                break
            }
        }
    }
    
    public func isFirstRequest() -> Bool {
        return NonceManager.nc == 0
    }
    
    public func cleanup(removePin: Bool) {
        if removePin {
//            Constants.Auth.kSysuser = nil
//            Constants.Auth.kPinCode = nil
//            self.isPin = false
        }
        
        self.cnonce = ""
        self.nonce = nil
        self.salt = nil
        self.hashalg = nil
        self.realm = nil
        self.qop = nil
        self.username = nil
        self.password = nil
        self.nc = ""
        NonceManager.nc = 0
    }
    
    private func getResponse(from uri: String, _ method: String) -> String? {
//        guard let qop = self.qop else { return nil }
//        guard let salt = self.salt else { return nil }
//        guard let realm = self.realm else { return nil }
//        guard let nonce = self.nonce else { return nil }
////        guard let usrn = self.isPin ? Constants.Auth.kSysuser : self.username else { return nil }
////        guard let pswd = self.isPin ? Constants.Auth.kPinCode : self.password else { return nil }
//        guard self.hashalg == "md5" || self.hashalg == "" else { return nil }
//
//        let nc = self.generateNC()
//        let cnonce = self.generateCnonce()
//        let decodedData = Data(base64Encoded: salt, options: .ignoreUnknownCharacters)!
//        let decodedSalt = String(data: decodedData, encoding: .utf8)!
////        let saltedPass = salt.isEmpty ? pswd.md5! : "\(pswd){\(decodedSalt)}".md5!
////        let a1 = "\(usrn):\(realm):\(saltedPass)".md5!
//        let a2 = "\(method):\(uri)".md5!
//        return "\(a1):\(nonce):\(nc):\(cnonce):\(qop):\(a2)".md5!
        return ""
    }
    
    private func generateNC() -> String {
        NonceManager.nc += 1
        let nc = String(NonceManager.nc)
        let str = String(repeating: "0", count: 8 - nc.count)
        self.nc = "\(str)\(nc)"
        return self.nc
    }
    
    private func generateCnonce() -> String {
        self.cnonce = ""
        for _ in 0..<128 {
            self.cnonce += String(format: "%ld", arc4random() % 9)
        }
        self.cnonce = self.cnonce.md5!
        return self.cnonce
    }
    
}
