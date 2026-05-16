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
    case cancel
    case write
    case post
}

extension CustomButtonType {
    var title: String {
        switch self {
        case .example: "예시 버튼"
        case .onboarding: "나의 아이쿠 기록 작성하기"
        case .cancel: "취소"
        case .write: "작성하기"
        case .post: "작성하기"
        }
    }
    
    var width: CGFloat {
        switch self {
        case .example: 355
        case .onboarding: 355
        case .cancel: 160
        case .write: 160
        case .post: 355
        }
    }
    
    var height: CGFloat {
        switch self {
        case .example: 44
        case .onboarding: 44
        case .cancel: 44
        case .write: 44
        case .post: 44
        }
    }
    
    var fontColor: UIColor {
        switch self {
        case .example: .black
        case .onboarding: .white
        case .cancel: . gray600
        case .write: .white
        case .post: .white
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .example: .blue
        case .onboarding: .gray
        case .cancel: .gray200
        case .write: .gray900
        case .post: .black
        }
    }
}
