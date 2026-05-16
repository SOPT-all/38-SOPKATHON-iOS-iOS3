//
//  ReviewEmotionView.swift
//  SOPKATHON-iOS3
//
//  Created by 초긍정행운의포춘쿠키 on 5/17/26.
//

import UIKit

import SnapKit
import Then

final class ReviewEmotionView: BaseUIView {
    
    // MARK: - Components
    
    private let emotionLabel = UILabel()
    
    private let buttonStack = UIStackView()
    
    private let button1 = UIButton()
    
    private let button2 = UIButton()
    
    private let button3 = UIButton()
    
    private let button4 = UIButton()
    
    private let reviewLabel = UILabel()
    
    private let reviewTextField = UITextField()
    
    private var emotionButtons: [UIButton] {
        [button1, button2, button3, button4]
    }
    
    // MARK: - UI Setting
    
    override func setStyle() {
        emotionLabel.do {
            $0.text = "감정을 표현해보세요!"
            $0.font = .body_r_12
            $0.textColor = .black
        }
        
        buttonStack.do {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 8
        }
        
        button1.do {
            $0.setImage(.emo1, for: .normal)
            $0.setImage(.emos1, for: .selected)
        }
        
        button2.do {
            $0.setImage(.emo2, for: .normal)
            $0.setImage(.emos2, for: .selected)
        }
        
        button3.do {
            $0.setImage(.emo3, for: .normal)
            $0.setImage(.emos3, for: .selected)
        }
        
        button4.do {
            $0.setImage(.emo4, for: .normal)
            $0.setImage(.emos4, for: .selected)
        }
        
        reviewLabel.do {
            $0.text = "회고를 작성해주세요!"
            $0.font = .body_r_12
            $0.textColor = .black
        }
        
        reviewTextField.do {
            $0.borderStyle = .roundedRect
            $0.returnKeyType = .done
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.textColor = .black
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 5
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.attributedPlaceholder = NSAttributedString(string: "회고를 작성하세요!", attributes: [ .foregroundColor: UIColor.gray, .font: UIFont.movie_13])
        }
    }

    override func setUI() {
        addSubviews(emotionLabel, buttonStack, reviewLabel, reviewTextField)
        buttonStack.addArrangedSubviews(button1, button2, button3, button4)
        
        // 각 버튼에 액션을 연결해야 터치했을 때 selected 이미지로 바뀐다.
        emotionButtons.enumerated().forEach { index, button in
            button.tag = index
            button.addTarget(self, action: #selector(emotionButtonDidTap(_:)), for: .touchUpInside)
        }
    }
    
    override func setLayout() {
        
        emotionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(emotionLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(10)
        }
        
        reviewTextField.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(67)
        }
    }
    
    // MARK: - Action
    
    @objc
    private func emotionButtonDidTap(_ sender: UIButton) {
        // 하나를 선택하면 나머지 버튼은 선택 해제해서 감정이 하나만 고르게 만든다.
        emotionButtons.forEach { button in
            button.isSelected = (button == sender)
        }
    }
    
}
