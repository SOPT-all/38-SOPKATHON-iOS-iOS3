//
//  UILabel+.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import UIKit

extension UILabel {
    func setLineSpacing(font: UIFont, ratio: CGFloat, textAlignment: NSTextAlignment = .left) {
        guard let text = self.text else { return }
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = font.pointSize * (ratio - 1.0)
        style.alignment = textAlignment
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: style
        ]
        
        self.attributedText = NSAttributedString(string: text, attributes: attributes)
    }
}
