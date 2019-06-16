//
//  DateTransform.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation
import ObjectMapper

class DashYMDDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    func transformFromJSON(_ value: Any?) -> Date? {
        guard let string = value as? String else { return nil }
        return DateFormat.dashYMD.getDate(from: string)
    }
    
    func transformToJSON(_ value: Date?) -> String? {
        guard let date = value else { return nil }
        return DateFormat.dashYMD.getString(from: date)
    }
}
