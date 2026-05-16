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
    
    private var serverHomeData: HomeData?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHomeData()
    }
    
    override func setDelegate() {
        mainView.collectionView.dataSource = self
        mainView.firstCardButton.addTarget(self, action: #selector(firstCardButtonDidTap), for: .touchUpInside)
        mainView.secondCardButton.addTarget(self, action: #selector(secondCardButtonDidTap), for: .touchUpInside)
    }
    
    // MARK: - Network Connection
    
    private func fetchHomeData() {
        MistakeService.shared.getHomeData(userId: 1) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let homeData = data as? HomeData else { return }
                self.serverHomeData = homeData
                
                self.bindServerData(homeData)
                
            case .requestErr(let message):
                print("⚠️ 요청 오류: \(message)")
            case .pathErr:
                print("⚠️ 디코딩 에러 발생")
            case .serverErr:
                print("⚠️ 서버 내부 오류")
            case .networkFail:
                print("⚠️ 네트워크 연결 상태 확인 요망")
            }
        }
    }
    
    private func bindServerData(_ data: HomeData) {
        mainView.welcomeLabel.text = "안녕하세요, \(data.user.name)님!"
        mainView.serialView.configure(count: data.user.streakCount)
        mainView.collectionView.reloadData()
    }
    
    // MARK: - Action Methods
    
    @objc private func firstCardButtonDidTap() {
        let nextVC = WriteMistakeViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        self.present(nextVC, animated: false, completion: nil)
    }
    
    @objc private func secondCardButtonDidTap() {
        let vc = MistakeAlbumViewController()
        navigationController?.pushViewController(vc, animated: true)
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
            
            if let homeData = serverHomeData {
                headerView.updateData(
                    with: homeData.dates,
                    streakCount: homeData.user.streakCount
                )
            }
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
}
