//
//  Font.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit

enum SFProTextFontStyle {
    case bold
    case medium
    case regular
    case semibold
}

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    /**
     - Parameter style: Подвид шрифта (Bold, Medium, Regular, Semibold)
     - Parameter size: Размер шрифта
     */
    static func SFProText(style: SFProTextFontStyle, ofSize size: CGFloat) -> UIFont {
        switch style {
        case .bold:
            return self.customFont(name: "SFProText-Bold", size: size)
        case .medium:
            return self.customFont(name: "SFProText-Medium", size: size)
        case .regular:
            return self.customFont(name: "SFProText-Regular", size: size)
        case .semibold:
            return self.customFont(name: "SFProText-Semibold", size: size)
        }
    }
    
}
