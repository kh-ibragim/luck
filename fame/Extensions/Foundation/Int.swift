//
//  Int.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Int {
    func toString() -> String? {
        guard self != nil else { return nil }
        return String(self!)
    }
}
