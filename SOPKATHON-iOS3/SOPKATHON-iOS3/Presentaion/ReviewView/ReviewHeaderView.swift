//
//  ReviewHeader.swift
//  SOPKATHON-iOS3
//
//  Created by 초긍정행운의포춘쿠키 on 5/17/26.
//

import UIKit

import SnapKit
import Then

protocol ReviewHeaderViewDelegate: AnyObject {
    func reviewHeaderViewDidTapBackButton(_ headerView: ReviewHeaderView)
}

final class ReviewHeaderView: BaseUIView {
    
    // MARK: - Properties
    
    weak var delegate: ReviewHeaderViewDelegate?
    
    // MARK: - Components
    
    private let headerLabel = UILabel()
    
    private let backButton = UIButton()
    
    // MARK: - UI Setting
    
    override func setStyle() {
        headerLabel.do {
            $0.text = "대단해 카드"
            $0.font = .title_sb_18
            $0.textColor = .black
        }
        
        backButton.do {
            $0.setImage(.btnBack, for: .normal)
        }
    }
    
    override func setUI() {
        addSubviews(headerLabel, backButton)
        
        // HeaderView는 화면 전환을 직접 하지 않고, 버튼 탭 이벤트만 VC에게 전달한다.
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
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
    
    // MARK: - Action
    
    @objc
    private func backButtonDidTap() {
        // navigationController는 ViewController가 가지고 있으므로 실제 push는 VC에서 처리한다.
        delegate?.reviewHeaderViewDidTapBackButton(self)
    }
}
