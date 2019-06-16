//
//  UIButton.swift
//  fame
//
//  Created by Ibragim Khasanov on 15/06/2019.
//  Copyright © 2019 Ibragim Khasanov. All rights reserved.
//

import UIKit

extension UIButton {
    
    /**
     Центрирует текст и иконку горизонтально и задает вертикальное расстояние от иконки до текста
     - Parameter spacing: Расстояние от иконки до текста
     */
    func alignVertically(spacing: CGFloat = 6.0) {
        guard let imageSize = self.imageView?.image?.size, let text = self.titleLabel?.text, let font = self.titleLabel?.font else {
            return
        }
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [.font: font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }
    
}
