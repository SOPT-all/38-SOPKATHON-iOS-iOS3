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
    
    private let reviewEmotion = ReviewEmotionView()
    
    private let postButton = CustomButton(type: .write)

    override func setStyle() {
        view.backgroundColor = .white
        
        postButton.do {
            $0.delegate = self
        }
    }

    override func setUI() {
        view.addSubviews(reviewHeader, reviewImageView, reviewEmotion, postButton)
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
        
        reviewEmotion.snp.makeConstraints {
            $0.top.equalTo(reviewImageView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(190)
        }
        
        postButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.width.equalTo(355)
            $0.height.equalTo(44)
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
    
    // 회고뷰 post 시 부를 함수임.. 이거 좀 고쳐야됨 일단 온보딩연결해놧는데 최종적으로는 교은이뷰로 연결해야함 !!!
    func pushToOnboardingViewController() {
        let vc = OnboardingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PostReviewViewController: ReviewHeaderViewDelegate {
    func reviewHeaderViewDidTapBackButton(_ headerView: ReviewHeaderView) {
        // HeaderView에서 전달받은 버튼 탭 이벤트를 실제 화면 이동으로 바꿔준다.
        pushToViewController()
    }
}

extension PostReviewViewController: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton, type: CustomButtonType) {
        // postButton이 눌리면 온보딩 화면으로 이동한다.
        pushToOnboardingViewController()
    }
}
