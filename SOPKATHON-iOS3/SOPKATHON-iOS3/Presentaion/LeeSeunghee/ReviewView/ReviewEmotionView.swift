//
//  ReviewEmotionView.swift
//  SOPKATHON-iOS3
//
//  Created by 초긍정행운의포춘쿠키 on 5/17/26.
//

import UIKit

import SnapKit
import Then

protocol ReviewEmotionViewDelegate: AnyObject {
    func reviewEmotionViewDidChangeInput(_ reviewEmotionView: ReviewEmotionView)
}

final class ReviewEmotionView: BaseUIView {
    
    // MARK: - Properties
    
    private let isEditable: Bool
    private let reviewText: String?
    private var selectedEmojiIndex: Int?
    
    weak var delegate: ReviewEmotionViewDelegate?
    
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
    
    private let normalEmotionImages: [UIImage] = [
        UIImage(resource: .emo1).withRenderingMode(.alwaysOriginal),
        UIImage(resource: .emo2).withRenderingMode(.alwaysOriginal),
        UIImage(resource: .emo3).withRenderingMode(.alwaysOriginal),
        UIImage(resource: .emo4).withRenderingMode(.alwaysOriginal)
    ]
    
    private let selectedEmotionImages: [UIImage] = [
        UIImage(resource: .emos1).withRenderingMode(.alwaysOriginal),
        UIImage(resource: .emos2).withRenderingMode(.alwaysOriginal),
        UIImage(resource: .emos3).withRenderingMode(.alwaysOriginal),
        UIImage(resource: .emos4).withRenderingMode(.alwaysOriginal)
    ]
    
    var selectedEmojiTag: Int? {
        selectedEmojiIndex
    }
    
    var selectedEmojiIndexForRequest: Int? {
        selectedEmojiIndex.map { $0 - 1 }
    }
    
    var content: String {
        reviewTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // MARK: - Initializer
    
    init(isEditable: Bool = true, reviewText: String? = nil) {
        self.isEditable = isEditable
        self.reviewText = reviewText
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            $0.setImage(normalEmotionImages[0], for: .normal)
            $0.setImage(selectedEmotionImages[0], for: .selected)
            $0.tag = 1
        }
        
        button2.do {
            $0.setImage(normalEmotionImages[1], for: .normal)
            $0.setImage(selectedEmotionImages[1], for: .selected)
            $0.tag = 2
        }
        
        button3.do {
            $0.setImage(normalEmotionImages[2], for: .normal)
            $0.setImage(selectedEmotionImages[2], for: .selected)
            $0.tag = 3
        }
        
        button4.do {
            $0.setImage(normalEmotionImages[3], for: .normal)
            $0.setImage(selectedEmotionImages[3], for: .selected)
            $0.tag = 4
        }
        
        reviewLabel.do {
            $0.text = "회고를 작성해주세요!"
            $0.font = .body_r_12
            $0.textColor = .black
        }
        
        reviewTextView.do {
            $0.font = .movie_13
            $0.textColor = .gray
            $0.text = reviewText
            $0.isEditable = isEditable
            $0.isSelectable = isEditable
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray200.cgColor
            $0.layer.cornerRadius = 5
            $0.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        }
        
        reviewPlaceholderLabel.do {
            $0.text = "내용을 입력해주세요!"
            $0.font = .movie_13
            $0.textColor = .gray500
            $0.numberOfLines = 0
            $0.isUserInteractionEnabled = false
            $0.isHidden = !isEditable || !(reviewText?.isEmpty ?? true)
        }
        
    }

    override func setUI() {
        addSubviews(emotionLabel, buttonStack, reviewLabel, reviewTextView)
        buttonStack.addArrangedSubviews(button1, button2, button3, button4)
        reviewTextView.addSubview(reviewPlaceholderLabel)
        
        // 작성 화면에서는 버튼 선택이 가능하고, 조회 화면에서는 서버에서 받은 selected 상태만 보여준다.
        emotionButtons.enumerated().forEach { index, button in
            button.tag = index + 1
            button.isUserInteractionEnabled = isEditable
            
            if isEditable {
                button.addTarget(self, action: #selector(emotionButtonDidTap(_:)), for: .touchUpInside)
            }
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
    
    func configureReviewText(_ text: String) {
        // 서버에서 GET 해온 회고 내용을 조회용/작성용 모두 같은 TextView에 채운다.
        reviewTextView.text = text
        reviewPlaceholderLabel.isHidden = true
    }
    
    func configureSelectedEmojiIndex(_ emojiIndex: Int) {
        let selectedTag = emojiIndex + 1
        selectedEmojiIndex = selectedTag
        print("configureSelectedEmojiIndex called:", emojiIndex, "selectedTag:", selectedTag)
        
        emotionButtons.enumerated().forEach { index, button in
            button.isSelected = false
            
            // 조회 화면에서는 selected 상태가 아니라 실제로 보이는 normal 이미지를 교체한다.
            let isSelectedEmoji = button.tag == selectedTag
            let image = isSelectedEmoji ? selectedEmotionImages[index] : normalEmotionImages[index]
            print("emoji button tag:", button.tag, "isSelectedEmoji:", isSelectedEmoji)
            
            button.setImage(image, for: .normal)
            button.setImage(image, for: .highlighted)
            button.setImage(image, for: .disabled)
            button.imageView?.image = image
            button.setNeedsLayout()
        }
    }
    
    func configureReflection(content: String, emojiIndex: Int) {
        // GET으로 받은 reflection.content와 reflection.emojiIndex를 조회 화면에 반영한다.
        configureReviewText(content)
        configureSelectedEmojiIndex(emojiIndex)
    }
    
    // MARK: - Action
    
    @objc
    private func emotionButtonDidTap(_ sender: UIButton) {
        guard isEditable else { return }
        
        // 하나를 선택하면 나머지 버튼은 선택 해제해서 감정이 하나만 고르게 만든다.
        emotionButtons.enumerated().forEach { index, button in
            button.isSelected = false
            
            let image = button == sender ? selectedEmotionImages[index] : normalEmotionImages[index]
            button.setImage(image, for: .normal)
            button.setImage(image, for: .highlighted)
        }
        selectedEmojiIndex = sender.tag
        delegate?.reviewEmotionViewDidChangeInput(self)
    }
    
}

extension ReviewEmotionView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // 사용자가 한 글자라도 입력하면 placeholder를 숨기고, 전부 지우면 다시 보여준다.
        reviewPlaceholderLabel.isHidden = !textView.text.isEmpty
        reviewEmotionViewDidChangeInput()
    }
    
    private func reviewEmotionViewDidChangeInput() {
        delegate?.reviewEmotionViewDidChangeInput(self)
    }
}
