//
//  MainViewController.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import UIKit

import SnapKit
import Then

final class MainViewController: BaseUIViewController {
    
    // MARK: - Properties
    
    private let mainView = MainView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setDelegate() {
        mainView.collectionView.dataSource = self
        mainView.firstCardButton.addTarget(self, action: #selector(firstCardButtonDidTap), for: .touchUpInside)
        mainView.secondCardButton.addTarget(self, action: #selector(secondCardButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func firstCardButtonDidTap() {
        let nextVC = WriteMistakeViewController()
        
        nextVC.modalPresentationStyle = .overFullScreen
        
        // animated를 false로 주면 아래에서 위로 올라오지 않고 즉시 등장합니다.
        self.present(nextVC, animated: false, completion: nil)
    }
    
    @objc private func secondCardButtonDidTap() {
        // 두 번째 버튼 눌렸을 때 로직 구현
    }
}

// MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainHeaderCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: MainHeaderCollectionView.identifier,
                for: indexPath
            ) as? MainHeaderCollectionView else { return UICollectionReusableView() }
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
}
