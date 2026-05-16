//
//  GetReviewViewController.swift
//  SOPKATHON-iOS3
//
//  Created by 초긍정행운의포춘쿠키 on 5/17/26.
//

import UIKit

import SnapKit
import Then

class GetReviewViewController: BaseUIViewController {
    
    private let userId = 1
    private let mistakeId = 1
    
    private let reviewHeader = ReviewHeaderView()
    
    private let reviewImageView = ReviewImageView(
        mistakeImage: nil,
        date: "",
        mistakeTitle: "",
        mistakeDescription: ""
    )
    
    private let reviewEmotion = ReviewEmotionView(
        isEditable: false,
        reviewText: nil
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMistakeDetail()
    }

    override func setStyle() {
        view.backgroundColor = .white
    }

    override func setUI() {
        view.addSubviews(reviewHeader, reviewImageView, reviewEmotion)
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
    }
    
    override func setDelegate() {
        // ReviewHeaderView 안의 backButton이 눌렸을 때 GetReviewViewController가 이벤트를 받도록 연결한다.
        reviewHeader.delegate = self
    }
    
    func pushToViewController() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureReviewText(_ text: String) {
        // 나중에 서버 GET 성공 시 이 함수에 응답 값을 넣으면 reviewTextView에 표시된다.
        reviewEmotion.configureReviewText(text)
    }
    
    private func getMistakeDetail() {
        GetReviewService.shared.getReview(userId: userId, mistakeId: mistakeId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let reviewData = data as? GetReviewResponse else { return }
                    self?.configureMistakeDetail(reviewData)
                case .requestErr(let message):
                    print("실수 상세 조회 요청 실패: \(message)")
                case .pathErr:
                    print("실수 상세 조회 디코딩 실패")
                case .serverErr:
                    print("실수 상세 조회 서버 에러")
                case .networkFail:
                    print("실수 상세 조회 네트워크 실패")
                }
            }
        }
    }
    
    private func configureMistakeDetail(_ data: GetReviewResponse) {
        reviewImageView.configure(
            imageUrl: data.imageUrl,
            date: data.date,
            title: data.title,
            content: data.content
        )
        
        if let reflection = data.reflection {
            print("GET reflection emojiIndex:", reflection.emojiIndex)
            reviewEmotion.configureReflection(
                content: reflection.content,
                emojiIndex: reflection.emojiIndex
            )
        } else {
            print("GET reflection is nil")
        }
    }
}

extension GetReviewViewController: ReviewHeaderViewDelegate {
    func reviewHeaderViewDidTapBackButton(_ headerView: ReviewHeaderView) {
        // HeaderView에서 전달받은 버튼 탭 이벤트를 실제 화면 이동으로 바꿔준다.
        pushToViewController()
    }
}
