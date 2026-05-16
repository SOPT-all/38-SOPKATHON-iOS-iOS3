//
//  ReviewHeader.swift
//  SOPKATHON-iOS3
//
//  Created by 초긍정행운의포춘쿠키 on 5/17/26.
//

import UIKit

import SnapKit
import Then

final class ReviewHeaderView: BaseUIView {
    
    // MARK: - Components
    
    private let headerLabel = UILabel()
    
    private let backButton = UIButton()
    
    // MARK: - UI Setting
    
    override func setStyle() {
        headerLabel.do {
            $0.text = "내 실수!"
            $0.font = .title_sb_16
            $0.textColor = .black
        }
        
        backButton.do {
            $0.setImage(.btnBack, for: .normal)
        }
    }
    
    override func setUI() {
        addSubviews(headerLabel, backButton)
    }
    
    override func setLayout() {
        
        headerLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
}
