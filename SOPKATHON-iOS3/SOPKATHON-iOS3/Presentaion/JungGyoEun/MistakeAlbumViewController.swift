//
//  MistakeAlbumViewController.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

import UIKit

import SnapKit
import Then

class MistakeAlbumViewController: BaseUIViewController {
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private let headerLabel = UILabel()
    private let subHeaderLabel = UILabel()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let lineSpacing: CGFloat = 8
    private let interItemSpacing: CGFloat = 5
    private let inset = UIEdgeInsets(top: 0, left: 9, bottom: 10, right: 9)
    
    private let userId: Int = 1
    private let pageSize: Int = 20
    
    private var itemList: [MistakeAlbumListItem] = []
    private var nextCursor: Int?
    private var hasNext: Bool = true
    private var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        register()
        fetchMistakeAlbumData()
    }
    
    override func setStyle() {
        backButton.do {
            $0.setImage(UIImage(named: "btn_back"), for: .normal)
        }
        
        titleLabel.do {
            $0.text = "나의 아이쿠!"
            $0.font = .title_sb_18
            $0.textColor = .black
        }
        
        headerLabel.do {
            $0.text = "렛솝님 그 때 그 ‘아이쿠’, 지금 어때요?"
            $0.font = .title_sb_16
            $0.textColor = .black
        }
        
        subHeaderLabel.do {
            $0.text = "과거에 기록했던 아이쿠 순간을 눌러서, 회고의 시간을 가져봐요!"
            $0.font = .caption_r_10
            $0.textColor = .gray600
        }
        
        collectionView.do {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    override func setUI() {
        view.addSubviews(backButton, titleLabel, headerLabel, subHeaderLabel, collectionView)
    }
    
    override func setLayout() {
        backButton.snp.makeConstraints{
            $0.size.equalTo(40)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().inset(-5)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerY.equalTo(backButton)
            $0.centerX.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalTo(backButton.snp.bottom).offset(20)
        }
        
        subHeaderLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalTo(headerLabel.snp.bottom).offset(3)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subHeaderLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setAddTarget() {
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
    }
    
    private func register() {
        collectionView.register(
            MistakeAlbumCollectionViewCell.self,
            forCellWithReuseIdentifier: MistakeAlbumCollectionViewCell.identifier
        )
    }
    
    private func fetchMistakeAlbumData(cursor: Int? = nil) {
        guard !isLoading else { return }
        guard cursor == nil || hasNext else { return }
        
        isLoading = true
        
        MistakeService.shared.getMistakeAlbumData(
            userId: userId,
            cursor: cursor,
            size: pageSize
        ) { [weak self] result in
            guard let self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success(let data):
                guard let albumData = data as? MistakeAlbumData else { return }
                
                if cursor == nil {
                    self.itemList = albumData.items
                } else {
                    self.itemList.append(contentsOf: albumData.items)
                }
                
                self.nextCursor = albumData.nextCursor
                self.hasNext = albumData.hasNext
                self.collectionView.reloadData()
                
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
    
    private func fetchNextPageIfNeeded(currentIndex: Int) {
        let thresholdIndex = itemList.count - 5
        
        guard currentIndex >= thresholdIndex else { return }
        guard hasNext, !isLoading, let nextCursor else { return }
        
        fetchMistakeAlbumData(cursor: nextCursor)
    }
    
    @objc private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension MistakeAlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = inset.left + inset.right + interItemSpacing * 2
        let cellWidth = floor((collectionView.bounds.width - totalSpacing) / 3)
        return CGSize(width: cellWidth, height: 132)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return inset
    }
}

extension MistakeAlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        fetchNextPageIfNeeded(currentIndex: indexPath.item)
    }
}

extension MistakeAlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MistakeAlbumCollectionViewCell.identifier,
            for: indexPath
        ) as? MistakeAlbumCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = itemList[indexPath.row]
        cell.configure(
            imageURL: item.imageUrl,
            hasReflection: item.hasReflection,
            emojiIndex: item.hasReflection ? item.emojiIndex : nil
        )
        
        return cell
    }
}
