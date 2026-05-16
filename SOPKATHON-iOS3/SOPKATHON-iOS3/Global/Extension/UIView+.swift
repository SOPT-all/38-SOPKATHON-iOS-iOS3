//
//  UIView+.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
