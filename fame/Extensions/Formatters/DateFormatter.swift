//
//  DateFormatter.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case YMD = "yyyyMMdd"
    case DMY = "ddMMyyyy"
    case dashYMD = "yyyy-MM-dd"
    case dashDMY = "dd-MM-yyyy"
    case dotYMD = "yyyy.MM.dd"
    case dotDMY = "dd.MM.yyyy"
    
    case dateTime = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case historyFormat = "dd.MM.yyyy HH:mm"
    case dateTimeSupport = "yyyy-MM-dd HH:mm:ss"
    
    case day = "dd"
    case month = "MMMM"
    case year = "yyyy"
    case dayMonth = "dd.MM"
    
    case time = "HH:mm"
    
    func getDate(from string: String) -> Date? {
        let df = DateFormatter()
        df.locale = Locale.init(identifier: "ru_RU")
        df.timeZone = TimeZone.ReferenceType.system
        df.dateFormat = self.rawValue
        return df.date(from: string)
    }
    
    func getString(from date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale.init(identifier: "ru_RU")
        df.timeZone = TimeZone.ReferenceType.system
        df.dateFormat = self.rawValue
        return df.string(from: date)
    }
}
