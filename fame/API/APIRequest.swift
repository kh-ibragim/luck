//
//  APIRequest.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Alamofire

struct APIPagination {
    var page: Int
    let per: Int
    
    var params: [String:Any] {
        return ["page": self.page, "take": self.per]
    }
    
    init(page: Int? = nil, per: Int? = nil) {
        self.page = page ?? 1
        self.per = per ?? 10
    }
    
    mutating func next() {
        self.page = self.page + 1
    }
}

struct APIRequest: URLRequestConvertible, URLConvertible {
    let method: String
    let version: APIVersion
    let path: String
    let params: [String: Any]?
    let body: [String: Any]?
    var headers: [String: String]
    let encodeUrl: Bool
    
    static func GET(_ path: String, version: APIVersion, params: [String: Any]? = nil, body: [String: Any]? = nil, encodeUrl: Bool = true, pagination: APIPagination? = nil) -> APIRequest {
        guard var _params = params else {
            return self.init(method: "GET", version: version, path: path, params: params, body: body, headers: [:], encodeUrl: encodeUrl)
        }
        if let pagination = pagination {
            for (key, value) in pagination.params {
                _params.updateValue(value, forKey: key)
            }
        }
        return self.init(method: "GET", version: version, path: path, params: _params, body: body, headers: [:], encodeUrl: encodeUrl)
    }
    
    static func POST(_ path: String, version: APIVersion, params: [String: Any]? = nil, body: [String: Any]? = nil, encodeUrl: Bool = false) -> APIRequest {
        return self.init(method: "POST", version: version, path: path, params: params, body: body, headers: [:], encodeUrl: encodeUrl)
    }
    
    static func PATCH(_ path: String, version: APIVersion, params: [String: Any]? = nil, body: [String: Any]? = nil, encodeUrl: Bool = false) -> APIRequest {
        return self.init(method: "PATCH", version: version, path: path, params: params, body: body, headers: [:], encodeUrl: encodeUrl)
    }
    
    static func PUT(_ path: String, version: APIVersion, params: [String: Any]? = nil, body: [String: Any]? = nil, encodeUrl: Bool = false) -> APIRequest {
        return self.init(method: "PUT", version: version, path: path, params: params, body: body, headers: [:], encodeUrl: encodeUrl)
    }
    
    static func DELETE(_ path: String, version: APIVersion, params: [String: Any]? = nil, body: [String: Any]? = nil, encodeUrl: Bool = false) -> APIRequest {
        return self.init(method: "DELETE", version: version, path: path, params: params, body: body, headers: [:], encodeUrl: encodeUrl)
    }
    
    func asURLRequest() throws -> URLRequest {
        let URL = self.URLBuilder(self.path, apiVersion: self.version)
        var request = URLRequest(url: URL)
        request.httpMethod = self.method
        request.timeoutInterval = 45
        
//        let headers = self.headers
//        for (key, value) in headers {
//            request.setValue(value, forHTTPHeaderField: key)
//        }
        if self.params != nil && self.encodeUrl {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        
        if let body = self.body {
            let data = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = data
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        API.sessionManager.version = self.version
        return try URLEncoding.queryString.encode(request, with: self.params)
    }
    
    func asURL() throws -> URL {
        return self.URLBuilder(self.path, apiVersion: self.version)
    }
    
    func URLBuilder(_ path: String, apiVersion: APIVersion) -> URL {
        let baseURL: URL?
            baseURL = URL(string: API.baseURLString)!
        let urlWithAPIVersion = baseURL!.appendingPathComponent("\(apiVersion.rawValue)")
        return urlWithAPIVersion.appendingPathComponent(path)
    }
}
