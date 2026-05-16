//
//  ReviewImageView.swift
//  SOPKATHON-iOS3
//
//  Created by 초긍정행운의포춘쿠키 on 5/17/26.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class ReviewImageView: BaseUIView {
    
    //MARK: - Properties
    
    private let mistakeImage: UIImage?
    
    private let date: String
    
    private let mistakeTitle : String
    
    private let mistakeDescription : String
    
    // MARK: - Components
    
    private let box = UIView()
    
    private let mistakeImageView = UIImageView()
    
    private let dateLabel = UILabel()
    
    private let mistakeTitleLabel = UILabel()
    
    private let mistakeDescriptionLabel = UILabel()
    
    //MARK: - Initializer
    init(mistakeImage: UIImage?, date: String, mistakeTitle: String, mistakeDescription: String) {
        self.mistakeImage = mistakeImage
        self.date = date
        self.mistakeTitle = mistakeTitle
        self.mistakeDescription = mistakeDescription
        
        super.init(frame: .zero)
    }
    
   required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setting
    
    override func setStyle() {
        box.do {
            $0.layer.cornerRadius = 16
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray.cgColor
        }
        
        mistakeImageView.do {
            $0.image = mistakeImage
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 12
            $0.clipsToBounds = true
        }
        
        dateLabel.do {
            $0.text = date
            $0.font = .body_r_12
            $0.textColor = .gray600
        }
        
        mistakeTitleLabel.do {
            $0.text = mistakeTitle
            $0.font = .title_sb_16
            $0.textColor = .gray900
        }
        
        mistakeDescriptionLabel.do {
            $0.text = mistakeDescription
            $0.font = .movie_13
            $0.textColor = .gray800
            $0.numberOfLines = 3
            $0.lineBreakMode = .byWordWrapping
        }
        
    }
    
    override func setUI() {
        addSubview(box)

        box.addSubviews(
            mistakeImageView,
            dateLabel,
            mistakeTitleLabel,
            mistakeDescriptionLabel
        )
    }
    
    override func setLayout() {
        
        box.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mistakeImageView.snp.makeConstraints {
            $0.top.equalTo(box.snp.top).offset(20)
            $0.horizontalEdges.equalTo(box.snp.horizontalEdges).inset(24)
            $0.height.equalTo(245)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(mistakeImageView.snp.bottom).offset(12)
            $0.leading.equalTo(mistakeImageView.snp.leading)
            $0.height.equalTo(18)
        }
        
        mistakeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(1)
            $0.leading.equalTo(mistakeImageView.snp.leading)
        }
        
        mistakeDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(mistakeTitleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(mistakeImageView.snp.horizontalEdges)
//            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    func configure(imageUrl: String, date: String, title: String, content: String) {
        if let url = URL(string: imageUrl) {
            mistakeImageView.kf.setImage(with: url)
        }
        dateLabel.text = date
        mistakeTitleLabel.text = title
        mistakeDescriptionLabel.text = content
    }
}
