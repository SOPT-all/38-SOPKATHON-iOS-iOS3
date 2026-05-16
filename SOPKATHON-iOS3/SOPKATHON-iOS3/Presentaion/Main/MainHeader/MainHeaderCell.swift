//
//  MainHeaderCell.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import UIKit

import SnapKit
import Then

final class MainHeaderCell: UICollectionViewCell {
    
    static let identifier = "MainHeaderCell"
    
    private let imageView = UIImageView()
    private let dayOfWeekLabel = UILabel()
    private let dateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setStyle() {
        dayOfWeekLabel.do {
            $0.font = .body_r_12
            $0.textColor = .black
            $0.textAlignment = .center
        }
        
        dateLabel.do {
            $0.font = .caption_l_10
            $0.textColor = .black
            $0.textAlignment = .center
        }
    }
    
    private func setUI() {
        contentView.addSubviews(imageView, dayOfWeekLabel, dateLabel)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(2.5)
            $0.size.equalTo(45)
        }
        
        dayOfWeekLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(dayOfWeekLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    func bindData(day: String, date: String, image: UIImage?) {
        imageView.image = image
        dayOfWeekLabel.text = day
        dateLabel.text = date
    }
}
