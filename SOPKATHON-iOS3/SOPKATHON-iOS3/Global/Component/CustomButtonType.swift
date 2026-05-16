//
//  CustomButtonType.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

import UIKit

enum CustomButtonType: CaseIterable {
    case example
    case onboarding
}

extension CustomButtonType {
    var title: String {
        switch self {
        case .example: "예시 버튼"
        case .onboarding: "작성하러가기"
        }
    }
    
    var width: CGFloat {
        switch self {
        case .example: 355
        case .onboarding: 355
        }
    }
    
    var height: CGFloat {
        switch self {
        case .example: 44
        case .onboarding: 44
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .example: .black
        case .onboarding: .black
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .example: .blue
        case .onboarding: .blue
        }
    }
}
