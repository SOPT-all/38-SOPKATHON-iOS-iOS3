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
    
    private let userId = 1
    private let mistakeId = 3
    
    private let reviewHeader = ReviewHeaderView()
    
    private let reviewImageView = ReviewImageView(
        mistakeImage: nil,
        date: "",
        mistakeTitle: "",
        mistakeDescription: ""
    )
    
    private let reviewEmotion = ReviewEmotionView()
    
    private let postButton = CustomButton(type: .post)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMistakeDetail()
    }

    override func setStyle() {
        view.backgroundColor = .white
        
        postButton.do {
            $0.delegate = self
            $0.isEnabled = false
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
        
        // 감정 선택 또는 회고 입력 값이 바뀌면 작성 버튼 활성화 여부를 다시 계산한다.
        reviewEmotion.delegate = self
    }
    
    func pushToViewController() {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToMistakeAlbumViewController() {
        let vc = MistakeAlbumViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func updatePostButtonState() {
        let hasSelectedEmoji = reviewEmotion.selectedEmojiIndexForRequest != nil
        let hasContent = !reviewEmotion.content.isEmpty
        postButton.isEnabled = hasSelectedEmoji && hasContent
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
    }
    
    private func postReview() {
        guard let emojiIndex = reviewEmotion.selectedEmojiIndexForRequest else { return }
        
        let request = PostReviewRequest(
            emojiIndex: emojiIndex,
            content: reviewEmotion.content
        )
        
        PostReviewService.shared.postReview(
            userId: userId,
            mistakeId: mistakeId,
            request: request
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.pushToMistakeAlbumViewController()
                case .requestErr(let message):
                    print("회고 작성 요청 실패: \(message)")
                case .pathErr:
                    print("회고 작성 디코딩 실패")
                case .serverErr:
                    print("회고 작성 서버 에러")
                case .networkFail:
                    print("회고 작성 네트워크 실패")
                }
            }
        }
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
        postReview()
    }
}

extension PostReviewViewController: ReviewEmotionViewDelegate {
    func reviewEmotionViewDidChangeInput(_ reviewEmotionView: ReviewEmotionView) {
        updatePostButtonState()
    }
}
