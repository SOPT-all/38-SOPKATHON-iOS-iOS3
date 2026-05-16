//
//  MistakeAlbumCollectionViewCell.swift
//  SOPKATHON-iOS3
//
//  Created by 정교은 on 5/17/26.
//

import UIKit

import Kingfisher
import SnapKit
import Then

final class MistakeAlbumCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "MistakeAlbumCollectionViewCell"
    
    private let itemImageView = UIImageView()
    private let stampImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setStyle()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.kf.cancelDownloadTask()
        itemImageView.image = nil
        stampImageView.image = nil
        stampImageView.isHidden = true
    }
    
    private func setUI() {
        contentView.addSubviews(itemImageView, stampImageView)
    }
    
    private func setStyle() {
        contentView.backgroundColor = .clear
        
        itemImageView.do {
            $0.backgroundColor = .systemGray5
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
        
        stampImageView.do {
            $0.contentMode = .scaleAspectFit
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        itemImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stampImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview()
        }
    }
    
    func configure(imageURL: String?, hasReflection: Bool, emojiIndex: Int?) {
        if let imageURL, let url = URL(string: imageURL) {
            itemImageView.kf.setImage(with: url)
        } else {
            itemImageView.image = nil
        }
        
        guard hasReflection, let emojiIndex else {
            stampImageView.isHidden = true
            return
        }
        
        stampImageView.image = UIImage(named: "stamp\(emojiIndex)")
        stampImageView.isHidden = false
    }
}
