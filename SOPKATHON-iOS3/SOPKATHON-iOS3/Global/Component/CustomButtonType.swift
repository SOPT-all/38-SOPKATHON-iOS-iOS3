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
        case .onboarding: "나의 아이쿠 기록 작성하기"
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
        case .onboarding: .white
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .example: .blue
        case .onboarding: .gray
        }
    }
}
