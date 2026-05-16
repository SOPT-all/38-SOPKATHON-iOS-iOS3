//
//  SerialView.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import UIKit

import SnapKit
import Then

final class SerialView: BaseUIView {
    private let containerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    
    private let fireImageView = UIImageView().then {
        $0.image = .fire
    }
    
    private let countLabel = UILabel().then {
        $0.text = "7"
        $0.textColor = .black
        $0.font = .body_m_14
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        self.backgroundColor = .white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.clipsToBounds = true
    }
    
    override func setUI() {
        self.addSubview(containerStackView)
        containerStackView.addArrangedSubviews(fireImageView, countLabel)
    }
    
    override func setLayout() {
        containerStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        fireImageView.snp.makeConstraints {
            $0.width.equalTo(8)
            $0.height.equalTo(12)
        }
    }
    
    func configure(count: Int) {
        countLabel.text = "\(count)"
    }
}
