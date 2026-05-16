//
//  MainView.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import UIKit

import SnapKit
import Then

final class MainView: BaseUIView {
    
    // MARK: - UI Components
    
    let welcomeLabel = UILabel()
    let subLabel = UILabel()
    
    let serialView = SerialView()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let writeMistakeLabel = UILabel()
    
    let firstCardButton = UIButton()
    let secondCardButton = UIButton()
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        welcomeLabel.do {
            $0.text = "안녕하세요, 렛솝님!"
            $0.font = .body_r_18
            $0.textColor = .black
        }
        
        subLabel.do {
            $0.text = "오늘은 어떤 아이쿠가 있었나요?"
            $0.font = .caption_r_10
            $0.textColor = .gray600
        }
        
        serialView.configure(count: 7)
        
        collectionView.do {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 130)
            
            $0.collectionViewLayout = layout
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            
            $0.register(
                MainHeaderCell.self,
                forCellWithReuseIdentifier: MainHeaderCell.identifier
            )
            
            $0.register(
                MainHeaderCollectionView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: MainHeaderCollectionView.identifier
            )
        }
        
        writeMistakeLabel.do {
            $0.text = "오늘의 아이쿠를 적어보자!"
            $0.font = .title_sb_16
            $0.textColor = .black
        }
        
        firstCardButton.do {
            $0.setImage(.homeFirstCard, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFill
        }
        
        secondCardButton.do {
            $0.setImage(.homeSecondCard, for: .normal)
            $0.imageView?.contentMode = .scaleAspectFill
        }
    }
    
    override func setUI() {
        [welcomeLabel, subLabel, serialView, collectionView, writeMistakeLabel, firstCardButton, secondCardButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setLayout() {
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(welcomeLabel)
        }
        
        serialView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(welcomeLabel.snp.bottom).offset(2)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        writeMistakeLabel.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        
        firstCardButton.snp.makeConstraints {
            $0.top.equalTo(writeMistakeLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(143)
        }
        
        secondCardButton.snp.makeConstraints {
            $0.top.equalTo(firstCardButton.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(143)
        }
    }
}
