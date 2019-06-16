//
//  StringValidation.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation

extension String {
    
    /// Проверка валидности карты алгоритмом Луна
    func isValidLuhn() -> Bool {
        var sum = 0
        let reversedCharacters = self.reversed().map { String($0) }
        for (idx, element) in reversedCharacters.enumerated() {
            guard let digit = Int(element) else { return false }
            switch ((idx % 2 == 1), digit) {
            case (true, 9): sum += 9
            case (true, 0...8): sum += (digit * 2) % 9
            default: sum += digit
            }
        }
        return sum % 10 == 0
    }
    
    /// Проверка, является ли строка почтовым адресом
    func isEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    /**
     Регулярное выражение для пароля
     - Parameter minLength: минимальное кол-во символов
     - Parameter useDigits: исп. хотя бы одну цифру (да или нет)
     - Parameter useSpecChars: исп. хотя бы один спец символ (да или нет)
     - Parameter isCaseSensetive: исп. хотя бы 1 маленькую и одну БОЛЬШУЮ букву (да или нет)
    */
    func isValidPassword(minLength: Int? = nil, useDigits: Bool? = nil, useSpecChars: Bool? = nil, isCaseSensetive: Bool? = nil) -> Bool {
        let minLength = minLength ?? 6
        let useDigits = (useDigits ?? true) ? "+" : "*"
        let useSpecChars = (useSpecChars ?? true) ? "+" : "*"
        let isCaseSensetive = (isCaseSensetive ?? false) ? "+" : "*"
        let regex = "^(?=(.*[0-9])\(useDigits))(?=(.*[!@#$%^&()+,:;=?\\|_/'<>.\"-])\(useSpecChars))(?=(.*[a-z])\(isCaseSensetive))(?=(.*[A-Z])\(isCaseSensetive))[0-9a-zA-Z!@#$%^&()+,:;=?-\\|_/'<>.\"-]{\(minLength),64}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
