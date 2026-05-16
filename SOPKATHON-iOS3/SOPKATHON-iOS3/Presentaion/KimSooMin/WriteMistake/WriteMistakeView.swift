//
//  WriteMistakeView.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import UIKit

import SnapKit
import Then

protocol WriteMistakeViewDelegate: AnyObject {
    func writeMistakeViewDidTapCancel(_ view: WriteMistakeView)
    func writeMistakeViewDidTapWrite(_ view: WriteMistakeView, title: String?, content: String?)
    func writeMistakeViewDidTapPhotoContainer(_ view: WriteMistakeView)
}

final class WriteMistakeView: BaseUIView {
    
    // MARK: - Properties
    
    weak var actionDelegate: WriteMistakeViewDelegate?
    
    // MARK: - UI Components
    
    private let contentView = UIView()
    private let photoContainerView = UIView()
    private let cameraIconImageView = UIImageView()
    private let addPhotoLabel = UILabel()
    private let titleHeaderLabel = UILabel()
    private let titleTextField = UITextField()
    private let contentHeaderLabel = UILabel()
    private let contentTextView = UITextView()
    private let contentPlaceholderLabel = UILabel()
    private let buttonStackView = UIStackView()
    
    let cancelButton = CustomButton(type: .cancel)
    let writeButton = CustomButton(type: .write)
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        contentView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 20
        }
        
        photoContainerView.do {
            $0.backgroundColor = .lightGray
            $0.layer.cornerRadius = 15
        }
        
        cameraIconImageView.do {
            $0.image = .icnCamera
        }
        
        addPhotoLabel.do {
            $0.text = "사진 추가하기"
            $0.font = .title_sb_18
            $0.textColor = .gray
        }
        
        titleHeaderLabel.do {
            $0.text = "제목"
            $0.font = .title_sb_16
            $0.textColor = .gray
        }
        
        titleTextField.do {
            $0.placeholder = "제목을 입력해주세요!"
            $0.font = .title_sb_16
            $0.textColor = .gray
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.cornerRadius = 5
            $0.addLeftPadding(14)
            $0.leftViewMode = .always
        }
        
        contentHeaderLabel.do {
            $0.text = "내용"
            $0.font = .title_sb_16
            $0.textColor = .gray
        }
        
        contentTextView.do {
            $0.font = .movie_13
            $0.textColor = .gray
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.cornerRadius = 5
            $0.textContainerInset = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        }
        
        contentPlaceholderLabel.do {
            $0.text = "내용을 입력해주세요!"
            $0.font = .movie_13
            $0.textColor = .gray
            $0.numberOfLines = 0
            $0.isUserInteractionEnabled = false
        }
        
        buttonStackView.do {
            $0.axis = .horizontal
            $0.spacing = 10
            $0.distribution = .fillEqually
        }
    }
    
    override func setUI() {
        addSubview(contentView)
        contentView.addSubviews(photoContainerView, titleHeaderLabel, titleTextField, contentHeaderLabel, contentTextView, buttonStackView)
        photoContainerView.addSubviews(cameraIconImageView, addPhotoLabel)
        contentTextView.addSubview(contentPlaceholderLabel)
        buttonStackView.addArrangedSubviews(cancelButton, writeButton)
    }
    
    override func setLayout() {
        contentView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        photoContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(180)
        }
        
        cameraIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-15)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        addPhotoLabel.snp.makeConstraints {
            $0.top.equalTo(cameraIconImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        titleHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(photoContainerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        titleTextField.snp.makeConstraints {
            $0.top.equalTo(titleHeaderLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        contentHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(contentHeaderLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(70)
        }
        
        contentPlaceholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(14)
            $0.trailing.equalToSuperview().offset(-14)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    override func setDelegate() {
        contentTextView.delegate = self
        cancelButton.delegate = self
        writeButton.delegate = self
    }
    
    func setAddTarget() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(photoContainerDidTap))
        photoContainerView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func photoContainerDidTap() {
        actionDelegate?.writeMistakeViewDidTapPhotoContainer(self)
    }
    
    func updateSelectedImage(_ image: UIImage) {
        cameraIconImageView.isHidden = true
        addPhotoLabel.isHidden = true
        
        let selectedImageView = UIImageView().then {
            $0.image = image
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }
        
        photoContainerView.addSubview(selectedImageView)
        selectedImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITextViewDelegate

extension WriteMistakeView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        contentPlaceholderLabel.isHidden = !textView.text.isEmpty
    }
}

// MARK: - CustomButtonDelegate (버튼 액션 수신 및 VC로 전달)

extension WriteMistakeView: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton, type: CustomButtonType) {
        switch type {
        case .cancel:
            actionDelegate?.writeMistakeViewDidTapCancel(self)
            
        case .write:
            let titleText = titleTextField.text
            let contentText = contentTextView.text
            actionDelegate?.writeMistakeViewDidTapWrite(self, title: titleText, content: contentText)
            
        default:
            break
        }
    }
}
