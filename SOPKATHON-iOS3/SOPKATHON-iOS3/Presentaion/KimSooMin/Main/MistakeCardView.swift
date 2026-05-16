//
//  MistakeCardView.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import UIKit

import SnapKit
import Then

final class MistakeCardView: BaseUIView {
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let characterImageView = UIImageView()
    
    override func setStyle() {
        titleLabel.do {
            $0.font = .heading_b_16
            $0.textColor = .black
            $0.text = "아이쿠! 카드"
        }
        
        descriptionLabel.do {
            $0.font = .movie_13
            $0.textColor = .black // 변경하자
            $0.text = "오늘의 아이쿠 순간,\n사진과 한 줄 남겨두기!"
            $0.numberOfLines = 2
            $0.setLineSpacing(font: .movie_13, ratio: 1.5)
        }
        
        characterImageView.do {
            $0.image = .imgHome1
        }
    }
    
    
    override func setUI() {
        backgroundColor = .green // 바꾸자
        addSubviews(titleLabel, descriptionLabel, characterImageView)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(29)
            $0.leading.equalToSuperview().inset(22)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
        }
        
        characterImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.size.equalTo(153)
        }
    }
}
