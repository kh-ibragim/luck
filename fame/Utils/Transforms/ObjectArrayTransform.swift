//
//  ObjectToArrayTransform.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import ObjectMapper

class ObjectArrayTransform<T: Mappable>: TransformType {
    public typealias Object = [T]
    public typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> [T]? {
        if let parsedArray = Mapper<T>(context: nil).mapArray(JSONObject: value!) {
            return parsedArray
        } else if let parsedObject = Mapper<T>(context: nil).map(JSONObject: value!) {
            return [parsedObject]
        } else {
            return nil
        }
    }
    
    func transformToJSON(_ value: [T]?) -> String? {
        return value?.toJSONString()
    }
}
