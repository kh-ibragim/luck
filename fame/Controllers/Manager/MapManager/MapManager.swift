//
//  MapManager.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation
extension API {
    enum Map: APIResource {
        typealias APIType = API
        
        case getObjects(latitude: String, longitude: String, text: String)
        var request: APIRequest {
            var request: APIRequest
            switch self {
            case .getObjects(let latitude, let longitude, let text):
                let ll = latitude + "," + longitude
                let params: [String: Any] = ["ll": ll,
                                             "text": text,
                                             "type": "biz",
                                             "lang": "ru_RU",
                                             "apikey": "8e62de3d-4334-46d4-bec3-5f7a1d5bb4ff",
                                             "size": "300,300",
                                             "spn": "0.05,0.05",
                                             "results":"500"]
                request = APIRequest.GET(Constants.Map.kAtms,version: .SupportApi, params: params, encodeUrl: false)
                
            }
            
            return request
        }
    }
}
