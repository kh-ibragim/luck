//
//  NonceSessionManager.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Alamofire

class DigestSessionManager: SessionManager {
    static var standard = DigestSessionManager(configuration: .ephemeral, delegate: SessionManager.default.delegate, serverTrustPolicyManager: nil)
    var version = APIVersion.SupportApi
    
    override init(configuration: URLSessionConfiguration, delegate: SessionDelegate, serverTrustPolicyManager: ServerTrustPolicyManager?) {
        super.init(configuration: configuration, delegate: delegate, serverTrustPolicyManager: serverTrustPolicyManager)
        let digestHandler = DigestHandler(self.version)
        self.adapter = digestHandler
        self.retrier = digestHandler
    }
}

class DigestHandler: RequestAdapter, RequestRetrier {
    private var version = APIVersion.SupportApi
    
    init(_ version: APIVersion) {
        self.version = version
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var request = urlRequest
        request.httpShouldHandleCookies = false
        
        if self.version == .SupportApi {
            var uri = ""
            if let path = urlRequest.url?.absoluteURL.getUri()?.replacingOccurrences(of: API.baseURLString, with: "") {
                uri = "/\(path)"
            }
            let SPDigest = NonceManager.shared.getHeader(from: uri, request.httpMethod) ?? NonceManager.shared.getPingHeader()
            request.setValue(SPDigest, forHTTPHeaderField: "Authorization")
        }
        print("⤴️⤴️⤴️request: \(request.httpMethod!) \(request.url!)\nbody: \(String(describing: request.httpBody))\nheaders: \(String(describing: request.allHTTPHeaderFields))⏹⏹⏹")
        return request
    }
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        guard request.retryCount == 0 else { return completion(false, 0.0) }
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            if let header = request.response?.allHeaderFields["Www-Authenticate"] as? String {
                if header.contains("stale=\"true\"") {
                    NonceManager.shared.updateNonce(from: header)
                    completion(true, 0.0)
                } else if NonceManager.shared.isFirstRequest() {
                    NonceManager.shared.parse(header)
                    completion(true, 0.0)
                } else {
                    completion(false, 0.0)
                }
            } else {
                completion(false, 0.0)
            }
        } else {
            completion(false, 0.0)
        }
    }
}
