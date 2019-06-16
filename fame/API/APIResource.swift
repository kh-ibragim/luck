//
//  APIResource.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Alamofire
import ObjectMapper

protocol APIResource {
    associatedtype APIType: APIController
    var request: APIRequest { get }
}

extension APIResource {
    @discardableResult
    func responseData(_ completionHandler: @escaping ResponseHandlerBlock) -> Request {
        return self.bpsRequest(completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseJSON(completionHandler: @escaping (_ json: Any?, _ error: NSError?) -> Void) -> Request {
        return self.bpsRequest(completionHandler: { (data, error) in
            do {
                guard error == nil else {
                    completionHandler(nil, error)
                    return
                }
                let JSON = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                completionHandler(JSON, nil)
            } catch {
                completionHandler(nil, error as NSError)
            }
        })
    }
    
    @discardableResult
    func responseObject<T: Mappable>(_ mappingType: T.Type, keyPath: String? = nil, completionHandler: @escaping (_ object: T?, _ error: NSError?) -> Void) -> Request {
        return self.responseJSON(completionHandler: { (json, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            var json = json as! [String: Any]?
            if let keyPath = keyPath {
                if let _json = json {
                    if let validJson = _json[keyPath] as? [String: Any] {
                        json = validJson
                    } else if let validJson = _json[keyPath] as? [String: String] {
                        json = validJson
                    } else {
                        completionHandler(nil, QError.standard(reason: "ObjectMapper failed to serialize response."))
                        return
                    }
                }
            }
            if let parsedObject = Mapper<T>(context: nil).map(JSON: json!) {
                completionHandler(parsedObject, nil)
                return
            }
            completionHandler(nil, QError.standard(reason: "ObjectMapper failed to serialize response."))
        })
    }
    
    @discardableResult
    func responseObjectArray<T: Mappable>(_ mappingType: T.Type, keyPath: String? = nil, completionHandler: @escaping (_ objects: [T]?, _ error: NSError?) -> Void) -> Request  {
        return self.responseJSON(completionHandler: { (json, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            guard json != nil else {
                completionHandler(nil, QError.standard(reason: "ObjectMapper failed to serialize response."))
                return
            }
            var jsonToMap: [[String : Any]]?
            if let keyPath = keyPath {
                guard let json = json as? [String : Any]? else {
                    completionHandler(nil, nil)
                    return
                }
                if let jsonArr = (json?[keyPath] as? [[String : Any]]?) {
                    jsonToMap = jsonArr
                } else if let jsonObj = (json?[keyPath] as? [String : Any]?) {
                    jsonToMap = [jsonObj] as? [[String : Any]]
                }
            } else {
                jsonToMap = json as! [[String : Any]]?
            }
            if let parsedArray: [T] = Mapper<T>(context: nil).mapArray(JSONObject: jsonToMap!) {
                completionHandler(parsedArray, nil)
            } else if let parsedObject = Mapper<T>(context: nil).map(JSONObject: jsonToMap!) {
                completionHandler([parsedObject], nil)
            } else {
                completionHandler(nil, QError.standard(reason: "ObjectMapper failed to serialize response."))
            }
        })
    }
}

typealias ResponseHandlerBlock = (_ data: Data?, _ error: NSError?) -> Void

extension APIResource {
    @discardableResult
    fileprivate func bpsRequest(completionHandler: @escaping ResponseHandlerBlock) -> Request {
        var request: DataRequest
        request = APIType.sessionManager.request(self.request)
        request = request.validate(statusCode: 200...204)
        request.response(queue: DispatchQueue.main, completionHandler: { (response) -> Void in
            var json = ""
            do {
                if let raw_json = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? Dictionary<String, AnyObject> {
                    json = String(describing: raw_json)
                } else if let raw_json = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as? Array<AnyObject> {
                    json = String(describing: raw_json)
                }
            } catch { }
            let serializedError = Self.errorSerializer(data: response.data, error: response.error as NSError?, response: response.response)
            
            guard serializedError == nil else {
                print("⤵️⤵️⤵️error:\ncode: \(serializedError!.code)\ndescription: \(serializedError!.userInfo)\nheaders: \(String(describing: request.response?.allHeaderFields))\n⏹⏹⏹")
                return completionHandler(nil, serializedError)
            }
            
            print("⤵️⤵️⤵️response:\n\(json)\n⏹⏹⏹")
            completionHandler(response.data, nil)
        })
        return request
    }
    
    fileprivate static func errorSerializer(data: Data?, error: NSError?, response: HTTPURLResponse?) -> NSError? {
        if let header = response?.allHeaderFields["Www-Authenticate"] as? String, response?.statusCode == 401 {
            //
        }
        
        if let header = response?.allHeaderFields["passwordExpired"] as? String {
            if header.contains("true") {
            //    LocalSessionManager.sharedManager.passwordExpire = true
            }
        }
        
        if let validData = data, validData.count > 0 {
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, AnyObject> {
                    if let errorMessage = json["errorMessage"] as? String {
                        let errorCode = Int(json["errorCode"] as? String ?? "-1") ?? -1
                        return QError.standard(reason: errorMessage, code: errorCode)
                    } else if json["errorText"] != nil {
                        var reason = json["errorText"] as? String
                        var errCode: Int
                        if let errorCode = json["errorCode"] as? Int {
                            errCode = errorCode
                        } else if let errorCode = response?.allHeaderFields["Error-Code"] as? String {
                            errCode = Int(errorCode)!
                        } else {
                            errCode = -1
                        }
                        return QError.standard(reason: reason ?? "Неизветсная ошибка", code: errCode)
                    } else if json["errorCode"] != nil {
//                        let errorCode = json["errorCode"] as? String ?? "-1"
//                        let reason = ErrorHandler().message(from: Int(errorCode)!)
//                        return QError.standard(reason: reason, code: Int(errorCode)!)
                        var reason: String
                        var errCode: Int
                        if let errorCode = json["errorCode"] as? Int {
                            errCode = errorCode
                            reason = ErrorHandler().message(from: errorCode)
                        } else if let errorCode = response?.allHeaderFields["Error-Code"] as? String {
                            errCode = Int(errorCode)!
                            reason = ErrorHandler().messageFromHeader(code: errCode)
                        } else {
                            errCode = -1
                            reason = ErrorHandler().message(from: -1)
                        }
                        return QError.standard(reason: reason, code: errCode)
                    } else if let errorCode = json["errorCode"] as? String {
                        let code = Int(errorCode) ?? -1
                        return QError.standard(reason: ErrorHandler().message(from: code), code: code)
                    }
                }
            } catch { }
        }
        if let errorCode = response?.allHeaderFields["Error-Code"] as? String {
            let code = Int(errorCode) ?? -1
            return QError.standard(reason: ErrorHandler().message(from: code), code: code)
        } else if let response = response, response.statusCode < 200 || response.statusCode > 204 {
            let statusCode = response.statusCode
            return QError.standard(reason: ErrorHandler().message(statusCode: statusCode), code: statusCode)
        }
        guard error == nil else {
            //return error
            return QError.standard(reason: ErrorHandler().message(from: error!.code), code: error!.code)
        }
        return nil
    }
}
