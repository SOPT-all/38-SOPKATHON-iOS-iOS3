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
    
    private let reviewTextView = UITextView()
    
    private let reviewPlaceholderLabel = UILabel()
    
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
        
        reviewTextView.do {
            $0.font = .movie_13
            $0.textColor = .gray
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.cornerRadius = 5
            $0.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        }
        
        reviewPlaceholderLabel.do {
            $0.text = "내용을 입력해주세요!"
            $0.font = .movie_13
            $0.textColor = .gray
            $0.numberOfLines = 0
            $0.isUserInteractionEnabled = false
        }
        
    }

    override func setUI() {
        addSubviews(emotionLabel, buttonStack, reviewLabel, reviewTextView)
        buttonStack.addArrangedSubviews(button1, button2, button3, button4)
        reviewTextView.addSubview(reviewPlaceholderLabel)
        
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
            $0.top.equalTo(buttonStack.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(67)
        }
        
        reviewPlaceholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview().inset(14)
        }
    }
    
    override func setDelegate() {
        // UITextView는 기본 placeholder가 없어서, 입력 여부를 delegate로 감지해 placeholderLabel을 숨긴다.
        reviewTextView.delegate = self
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

extension ReviewEmotionView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 사용자가 한 글자라도 입력하면 placeholder를 숨기고, 전부 지우면 다시 보여준다.
        reviewPlaceholderLabel.isHidden = !textView.text.isEmpty
    }
}
