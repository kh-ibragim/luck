//
//  Float.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation

extension String {
    
    /**
     Получить числовое значение из строки с суммой
     - Returns: Сумма во Float?
     */
    var asFloatAmount: Float? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.number(from: self)?.floatValue
    }
    
    /**
     Получить числовое значение из строки с суммой
     - Returns: Сумма в Double?
     */
    var asDoubleAmount: Double? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter.number(from: self)?.doubleValue
    }
    
    /**
     Получить отформатированную числовую строку из исходной строки с суммой
     - Returns: Сумма в String?
     */
    var asAmount: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        guard let value = formatter.number(from: self) else { return nil }
        return formatter.string(from: value)
    }
    
    /**
     Получить отформатированную числовую строку из другой отформатированной строки с суммой
     - Returns: Сумма в String?
     */
    var asMoney: String? {
        let cleanValue = self.replacingOccurrences(of: " ", with: "")
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        guard let value = formatter.number(from: cleanValue) else { return nil }
        return formatter.string(from: value)
    }
    
    /**
     Получить сумму из двух символов после разделителя
     - Returns: Сумма в String?
     */
    var asTwoFractionDigits: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = ""
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        guard let value = formatter.number(from: self) else { return nil }
        return formatter.string(from: value)
    }
    
    var asCleanAmount: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    var getClearAmount: String {
        return self.replacingOccurrences(of: "XAG", with: "").replacingOccurrences(of: "C$", with: "").replacingOccurrences(of: "¥", with: "").replacingOccurrences(of: "₽", with: "").replacingOccurrences(of: "DKK", with: "").replacingOccurrences(of: "NOK", with: "").replacingOccurrences(of: "$", with: "").replacingOccurrences(of: "XPT", with: "").replacingOccurrences(of: "XPD", with: "").replacingOccurrences(of: "€", with: "").replacingOccurrences(of: "£", with: "").replacingOccurrences(of: "KRS", with: "").replacingOccurrences(of: "XAU", with: "").replacingOccurrences(of: "₣", with: "").replacingOccurrences(of: "A$", with: "").replacingOccurrences(of: " ", with: "")
    }
    mutating func verificationTwoNumbers(str: String) -> String {
        if self.contains(".") {
            let components = self.components(separatedBy: ".")
            if components.count == 2 {
                if  components[1].length < 3{
                    return str
                } else {
                    let strWithout = String(str.dropLast())
                    return strWithout
                }
            }
        } else if self.contains(",") {
            let components = self.components(separatedBy: ",")
            if components.count == 2 {
                if  components[1].length < 3{
                    return str
                } else {
                    let strWithout = String(str.dropLast())
                    return strWithout
                }
            }
        }
        return str
    }
    
    func clearMobile() -> String {
        return self.replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "")
    }
    
}
