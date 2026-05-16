//
//  UIStackView+.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
