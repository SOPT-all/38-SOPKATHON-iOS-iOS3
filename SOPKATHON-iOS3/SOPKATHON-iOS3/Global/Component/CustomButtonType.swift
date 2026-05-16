//
//  CustomButtonType.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

import UIKit

enum CustomButtonType: CaseIterable {
    case example
}

extension CustomButtonType {
    var title: String {
        switch self {
        case .example: "예시 버튼"
            
        }
    }
    
    var width: CGFloat {
        switch self {
        case .example: 355
        }
    }
    
    var height: CGFloat {
        switch self {
        case .example: 44
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .example: .black
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .example: .blue
        }
    }
}
