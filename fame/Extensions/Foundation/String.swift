//
//  String.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation
import UIKit
import CommonCryptoModule
import InputMask

/// Перечисление валют (сокращения)
enum Currency: String {
    case XAG = "XAG"
    case CAD = "CAD"
    case CNY = "CNY"
    case RUR = "RUR"
    case DKK = "DKK"
    case NOK = "NOK"
    case USD = "USD"
    case XPT = "XPT"
    case XPD = "XPD"
    case EUR = "EUR"
    case GBP = "GBP"
    case KRS = "KRS"
    case XAU = "XAU"
    case CHF = "CHF"
    case AUD = "AUD"
}

/// Перечисление валют (символы)
enum CurrencySymbol: String {
    case XAG = "XAG"
    case CAD = "C$"
    case CNY = "¥"
    case RUR = "₽"
    case DKK = "DKK"
    case NOK = "NOK"
    case USD = "$"
    case XPT = "XPT"
    case XPD = "XPD"
    case EUR = "€"
    case GBP = "£"
    case KRS = "KRS"
    case XAU = "XAU"
    case CHF = "₣"
    case AUD = "A$"
}

extension String {
    
    /// Возвращает длинну строки
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    var formattedPhone: String {
//        let mask = try! Mask.getOrCreate(withFormat: "+[0] *** *** [0000]") //don't work
//        let result: Mask.Result = mask.apply(
//            toText: CaretString(
//                string: self,
//                caretPosition: self.endIndex
//            ),
//            autocomplete: false
//        )
//        return result.formattedText.string
        let str = "+" + self.prefix(1) + " *** *** " + self.suffix(4)
        return str
    }
    
    var boolValue: Bool? {
        get {
            if self == "true" {
                return true
            }
            if self == "false" {
                return false
            }
            return nil
        }
    }
    
    /**
        Устанавливает символ валюты в конец строки по сокращению валюты
     - Parameter symbol: сокр. валюты
     - Returns: исходная строка с символом валюты в конце
     */
    func setCurrency(symbol: Currency) -> String {
        var amount: String = self
        var sign = ""
        
        switch symbol {
        case .XAG: sign = " \(CurrencySymbol.XAG.rawValue)"
        case .CAD: sign = " \(CurrencySymbol.CAD.rawValue)"
        case .CNY: sign = " \(CurrencySymbol.CNY.rawValue)"
        case .RUR: sign = " \(CurrencySymbol.RUR.rawValue)"
        case .DKK: sign = " \(CurrencySymbol.DKK.rawValue)"
        case .NOK: sign = " \(CurrencySymbol.NOK.rawValue)"
        case .USD: sign = " \(CurrencySymbol.USD.rawValue)"
        case .XPT: sign = " \(CurrencySymbol.XPT.rawValue)"
        case .XPD: sign = " \(CurrencySymbol.XPD.rawValue)"
        case .EUR: sign = " \(CurrencySymbol.EUR.rawValue)"
        case .GBP: sign = " \(CurrencySymbol.GBP.rawValue)"
        case .KRS: sign = " \(CurrencySymbol.KRS.rawValue)"
        case .XAU: sign = " \(CurrencySymbol.XAU.rawValue)"
        case .CHF: sign = " \(CurrencySymbol.CHF.rawValue)"
        case .AUD: sign = " \(CurrencySymbol.AUD.rawValue)"
        }
        
        amount.append(sign)
        return amount
    }
    
    /**
     Получить символ валюты из валюты
     - Parameter symbol: сокр. валюты
     - Returns: строка с символом валюты в конце
     */
    static func getSymbol(from currency: Currency) -> String {
        switch currency {
        case .XAG: return CurrencySymbol.XAG.rawValue
        case .CAD: return CurrencySymbol.EUR.rawValue
        case .CNY: return CurrencySymbol.EUR.rawValue
        case .RUR: return CurrencySymbol.RUR.rawValue
        case .DKK: return CurrencySymbol.EUR.rawValue
        case .NOK: return CurrencySymbol.EUR.rawValue
        case .USD: return CurrencySymbol.USD.rawValue
        case .XPT: return CurrencySymbol.EUR.rawValue
        case .XPD: return CurrencySymbol.EUR.rawValue
        case .EUR: return CurrencySymbol.EUR.rawValue
        case .GBP: return CurrencySymbol.EUR.rawValue
        case .KRS: return CurrencySymbol.EUR.rawValue
        case .XAU: return CurrencySymbol.XAU.rawValue
        case .CHF: return CurrencySymbol.EUR.rawValue
        case .AUD: return CurrencySymbol.EUR.rawValue
        }
    }
    
    /**
     Устанавливает символ валюты в конец строки по коду валюты
     - Parameter code: код валюты
     - Returns: исходная строка с символом валюты в конце
     */
    func setCurrency(code: String) -> String {
        var amount: String = self
        var sign = ""
        
        switch code {
        case "A99": sign = " \(CurrencySymbol.XAG.rawValue)"
        case "124": sign = " \(CurrencySymbol.CAD.rawValue)"
        case "156": sign = " \(CurrencySymbol.CNY.rawValue)"
        case "810": sign = " \(CurrencySymbol.RUR.rawValue)"
        case "208": sign = " \(CurrencySymbol.DKK.rawValue)"
        case "578": sign = " \(CurrencySymbol.NOK.rawValue)"
        case "840": sign = " \(CurrencySymbol.USD.rawValue)"
        case "A76": sign = " \(CurrencySymbol.XPT.rawValue)"
        case "A33": sign = " \(CurrencySymbol.XPD.rawValue)"
        case "978": sign = " \(CurrencySymbol.EUR.rawValue)"
        case "826": sign = " \(CurrencySymbol.GBP.rawValue)"
        case "116": sign = " \(CurrencySymbol.KRS.rawValue)"
        case "A98": sign = " \(CurrencySymbol.XAU.rawValue)"
        case "756": sign = " \(CurrencySymbol.CHF.rawValue)"
        case "036": sign = " \(CurrencySymbol.AUD.rawValue)"
        default: sign = ""
        }
        
        amount.append(sign)
        return amount
    }
    
    /// Получить валюту из цифр кода
    func getCurrency() -> Currency? {
        switch self {
        case "A99": return .XAG
        case "124": return .CAD
        case "156": return .CNY
        case "810": return .RUR
        case "208": return .DKK
        case "578": return .NOK
        case "840": return .USD
        case "A76": return .XPT
        case "A33": return .XPD
        case "978": return .EUR
        case "826": return .GBP
        case "116": return .KRS
        case "A98": return .XAU
        case "756": return .CHF
        case "036": return .AUD
        default: return nil
        }
    }
    
    /**
     Получить название валюты на русском
     - Parameter currency: валюта
     - Returns: Название валюты на русском языке
     */
    static func getName(from currency: Currency) -> String {
        switch currency {
        case .XAG: return "Унция серебра"
        case .CAD: return "Канадский доллар"
        case .CNY: return "Китайский юань"
        case .RUR: return "Российский рубль"
        case .DKK: return "Данская крона"
        case .NOK: return "Норвежская крона"
        case .USD: return "Доллары США"
        case .XPT: return "Унция платины"
        case .XPD: return "Унция палладия"
        case .EUR: return "Евро"
        case .GBP: return "Фунт стерлингов"
        case .KRS: return "Крипстал"
        case .XAU: return "Унция золота"
        case .CHF: return "Швейцарский франк"
        case .AUD: return "Австралийские доллар"
        }
    }
    
    /// Получить цифровой код валюты
    static func getCode(from currency: Currency) -> String {
        switch currency {
        case .XAG: return "A99"
        case .CAD: return "124"
        case .CNY: return "156"
        case .RUR: return "810"
        case .DKK: return "208"
        case .NOK: return "578"
        case .USD: return "840"
        case .XPT: return "A76"
        case .XPD: return "A33"
        case .EUR: return "978"
        case .GBP: return "826"
        case .KRS: return "116"
        case .XAU: return "A98"
        case .CHF: return "756"
        case .AUD: return "036"
        }
    }
    
    func setAttributedAmount(color: UIColor) -> NSMutableAttributedString? {
        let attributedString = NSMutableAttributedString(string: self)
        if self.length > 4 {
            attributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: self.length - 4, length: 4))
        } else if length > 0 {
            attributedString.addAttribute(.foregroundColor, value: color, range: NSRange(location: self.length - 1, length: 1))
        }
        return attributedString
    }
    
    /// Возвращает строку в нижнем регистре с первым заглавным символом
    var asTitle: String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    /// Алгоритм шифрования MD5. Возвращает хэш только в нижнем регистре
    var md5: String? {
        guard let data = self.data(using: .utf8) else { return nil }
        let hash = data.withUnsafeBytes { (bytes: UnsafePointer<Data>) -> [UInt8] in
            var hash: [UInt8] = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0).lowercased() }.joined()
    }
    
    /// Маска, пригодная для InputMask
    var asMask: String {
        var output = ""
        var mask = self.replacingOccurrences(of: "9", with: "0")
        mask = mask.replacingOccurrences(of: "a", with: "A")
        mask = mask.replacingOccurrences(of: "*", with: "_")
        
        for (_, character) in mask.enumerated() {
            var char = String(character)
            if char == "0" || char == "A" || char == "_"{
                char = "[\(char)]"
            }
            output += char
        }
        
        return output
    }
    
    /// Получить значение из маски
    func getCleanValue(from mask: String) -> String? {
        var value = ""
        let cleanMask = mask.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        let cleanValue = self.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        guard cleanMask.count == cleanValue.count else { return nil }
        
        for index in 0..<cleanMask.count {
            let character = cleanMask[index]
            if character == "0" || character == "A" {
                value += String(cleanValue[index])
            }
        }
        
        return value
    }
    
    /// Получить строку имени класса
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
        func href() -> [String]
        {
            if let regex = try? NSRegularExpression(pattern: "<a[^>]+href[ ]*=[ ]*\"(.*?)\"[^>]*>(.*?)</a>", options: .caseInsensitive)
            {
                let string = self as NSString
                return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
                    string.substring(with: $0.range)
                }
            }
            return []
        }
}
