//
//  UITextField.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit

extension UITextField {
    var cursorOffset: Int? {
        guard let range = selectedTextRange else { return nil }
        return offset(from: beginningOfDocument, to: range.start)
    }
    
    var cursorIndex: String.Index? {
        guard let cursorOffset = self.cursorOffset else { return nil }
        guard let text = self.text else { return nil }
        return text.index(text.startIndex, offsetBy: cursorOffset, limitedBy: text.endIndex)
    }
}
