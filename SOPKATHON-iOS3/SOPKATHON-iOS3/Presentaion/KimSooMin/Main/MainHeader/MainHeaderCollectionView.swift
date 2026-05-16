//
//  MainHeaderCollectionView.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import UIKit

import SnapKit
import Then

final class MainHeaderCollectionView: UICollectionReusableView {
    
    static let identifier = "MainHeaderCollectionView"
    
    private var dateList: [DateStrip] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = 15
            $0.minimumLineSpacing = 15
            $0.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .clear
        }
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        setCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubview(collectionView)
    }
    
    private func setLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(
            MainHeaderCell.self,
            forCellWithReuseIdentifier: MainHeaderCell.identifier
        )
    }
    
    func updateData(with dates: [DateStrip]) {
        self.dateList = dates
        self.collectionView.reloadData()
    }
}

extension MainHeaderCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainHeaderCell.identifier,
            for: indexPath
        ) as? MainHeaderCell else { return UICollectionViewCell() }
        
        let data = dateList[indexPath.item]
        
        cell.bindData(day: data.dayOfWeek, date: data.formattedDate)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 110)
    }
}
