//
//  ReviewView.swift
//  SOPKATHON-iOS3
//
//  Created by 초긍정행운의포춘쿠키 on 5/17/26.
//

import UIKit

import SnapKit
import Then

class PostReviewViewController: BaseUIViewController {
    
    private let reviewHeader = ReviewHeaderView()
    
    private let reviewImageView = ReviewImageView(
        mistakeImage: .btnBack,
        date: "26.04.13",
        mistakeTitle: "오늘의 엣큥",
        mistakeDescription: "이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 이나연 사랑해 "
    )

    override func setStyle() {
        view.backgroundColor = .white
    }

    override func setUI() {
        view.addSubviews(reviewHeader, reviewImageView)
    }

    override func setLayout() {
        reviewHeader.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        reviewImageView.snp.makeConstraints {
            $0.top.equalTo(reviewHeader.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(380)
        }
    }
    
    override func setDelegate() {
        // ReviewHeaderView 안의 버튼이 눌렸을 때 PostReviewViewController가 이벤트를 받도록 연결한다.
        reviewHeader.delegate = self
    }
    
    func pushToViewController() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PostReviewViewController: ReviewHeaderViewDelegate {
    func reviewHeaderViewDidTapBackButton(_ headerView: ReviewHeaderView) {
        // HeaderView에서 전달받은 버튼 탭 이벤트를 실제 화면 이동으로 바꿔준다.
        pushToViewController()
    }
}
