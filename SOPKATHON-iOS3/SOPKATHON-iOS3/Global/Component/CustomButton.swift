//
//  CustomButtonDelegate.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//


import UIKit

import SnapKit
import Then

protocol CustomButtonDelegate: AnyObject {
    func customButtonDidTap(_ button: CustomButton, type: CustomButtonType)
}

final class CustomButton: UIButton {
    
    private let customButtonType: CustomButtonType
    
    weak var delegate: CustomButtonDelegate?
    
    private let buttonLabel = UILabel()
    private let buttonView = UIView()
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.4
        }
    }
    
    init(type: CustomButtonType) {
        self.customButtonType = type
        super.init(frame: .zero)
        
        setStyle()
        setUI()
        setLayout()
        
        addTarget(self, action: #selector(customButtonDidTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        buttonLabel.do {
            $0.text = customButtonType.title
            $0.font = .heading_sb_20
            $0.textColor = customButtonType.fontColor
        }
        
        buttonView.do {
            $0.backgroundColor = customButtonType.backgroundColor
            $0.layer.cornerRadius = 10
            $0.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 2
            $0.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    private func setUI() {
        addSubviews(buttonView,buttonLabel)
        buttonView.isUserInteractionEnabled = false
    }
    
    private func setLayout() {
        buttonView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(customButtonType.width)
            $0.height.equalTo(customButtonType.height)
        }
        
        buttonLabel.snp.makeConstraints {
            $0.centerX.equalTo(buttonView)
            $0.centerY.equalTo(buttonView)
        }
    }
    
    //MARK: - Action
    
    @objc
    private func customButtonDidTap() {
        delegate?.customButtonDidTap(self, type: customButtonType)
    }
}
