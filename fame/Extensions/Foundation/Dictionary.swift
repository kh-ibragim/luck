//
//  Dictionary.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation

extension Dictionary {
    
    /// Соединяет два словаря (правый к левому) (Dictionary)
    static func += <K, V> (left: inout [K: V], right: [K: V]) {
        for (k, v) in right {
            left[k] = v
        }
    }
    
    /// Присоединяет another словарь из параметров к текущему
    mutating func addValues(from another: Dictionary) {
        for (k, v) in another {
            self.updateValue(v, forKey: k)
        }
    }
    
    /// Получить ключ по индексу
    func keyAt(_ index: Int) -> Any {
        return Array(self.keys)[index]
    }
    
    /// Получить значение по индексу
    func valueAt(_ index: Int) -> Any {
        return Array(self.values)[index]
    }
}
