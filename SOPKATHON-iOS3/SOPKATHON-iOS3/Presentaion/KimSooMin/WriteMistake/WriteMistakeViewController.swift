//
//  WriteMistakeViewController.swift
//  SOPKATHON-iOS3
//
//  Created by mandoo on 5/17/26.
//

import UIKit
import PhotosUI

import SnapKit
import Then

final class WriteMistakeViewController: BaseUIViewController {
    
    // MARK: - UI Components
    
    private let mainView = WriteMistakeView()
    private let bgDimmedImageView = UIImageView()
    private var selectedImage: UIImage?
    
    // MARK: - Custom Methods
    
    override func setStyle() {
        view.backgroundColor = .clear
        
        bgDimmedImageView.do {
            $0.image = .imgModalopacity
            $0.contentMode = .scaleAspectFill
        }
    }
    
    override func setUI() {
        view.addSubviews(bgDimmedImageView, mainView)
    }
    
    override func setLayout() {
        bgDimmedImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setDelegate() {
        mainView.actionDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bgDimmedImageView.alpha = 0
        mainView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.hideKeyboardWhenTappedAround()
        
        UIView.animate(withDuration: 0.2) {
            self.bgDimmedImageView.alpha = 1
            self.mainView.alpha = 1
        }
    }
}

extension WriteMistakeViewController: WriteMistakeViewDelegate {
    
    func writeMistakeViewDidTapCancel(_ view: WriteMistakeView) {
        dismissModal()
    }
    
    func writeMistakeViewDidTapWrite(_ view: WriteMistakeView, title: String?, content: String?) {
        guard let title = title, !title.isEmpty,
              let content = content, !content.isEmpty else {
            print("⚠️ 제목과 내용을 채워주세요.")
            return
        }
        
        guard let image = selectedImage,
              let imageData = image.pngData() else {
            print("⚠️ 이미지를 데이터로 변환하는 데 실패했습니다.")
            return
        }
        
        let filename = "ios_upload_\(Int(Date().timeIntervalSince1970)).png"
        let contentType = "image/png"
        let contentLength = imageData.count
        
        print("🚀 [1단계 시작] Presigned URL 발급 요청 중...")
        
        MistakeService.shared.issuePresignedURL(filename: filename, type: contentType, size: contentLength) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                guard let presignedData = data as? PresignedUploadData else { return }
                
                print("🚀 [2단계 시작] 발급 성공 -> 바이너리 업로드 중...")
                
                MistakeService.shared.uploadImageBinary(url: presignedData.uploadUrl, imageData: imageData, contentType: contentType) { success in
                    if success {
                        print("🚀 [3단계 시작] 바이너리 업로드 성공 -> 서버 최종 완료 검증 요청 중...")
                        
                        MistakeService.shared.verifyImageUploadComplete(objectKey: presignedData.objectKey, type: contentType, size: contentLength) { verifyResult in
                            switch verifyResult {
                            case .success(let verifyData):
                                guard let completeData = verifyData as? ImageCompleteData else { return }
                                
                                print("🚀 [최종 단계 시작] 검증 성공 -> 최종 실수 카드 생성 중...")
                                
                                MistakeService.shared.createMistake(userId: 1, title: title, content: content, objectKey: completeData.objectKey) { finalResult in
                                    switch finalResult {
                                    case .success:
                                        print("🎉 실수 작성 완료 성공!")
                                        NotificationCenter.default.post(name: NSNotification.Name("RefreshHomeData"), object: nil)
                                        
                                        UIView.animate(withDuration: 0.2, animations: {
                                            self.bgDimmedImageView.alpha = 0
                                            self.mainView.alpha = 0
                                        }) { _ in
                                            let albumVC = MistakeAlbumViewController()
                                            self.navigationController?.pushViewController(albumVC, animated: true)
                                        }
                                    case .requestErr(let msg): print("최종 에러: \(msg)")
                                    default: print("최종 기록 실패")
                                    }
                                }
                            case .requestErr(let msg): print("3단계 검증 에러: \(msg)")
                            default: print("3단계 통신 오류")
                            }
                        }
                    } else {
                        print("❌ 2단계 바이너리 자체 업로드 실패")
                    }
                }
            case .requestErr(let msg): print("1단계 발급 에러: \(msg)")
            default: print("1단계 통신 오류")
            }
        }
    }
    
    func writeMistakeViewDidTapPhotoContainer(_ view: WriteMistakeView) {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    private func dismissModal() {
        UIView.animate(withDuration: 0.2, animations: {
            self.bgDimmedImageView.alpha = 0
            self.mainView.alpha = 0
        }) { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
}

// MARK: - PHPickerViewControllerDelegate

extension WriteMistakeViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let result = results.first else { return }
        let itemProvider = result.itemProvider
        
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                guard let self = self, let image = image as? UIImage, error == nil else { return }
                
                self.selectedImage = image
                
                DispatchQueue.main.async {
                    self.mainView.updateSelectedImage(image)
                }
            }
        }
    }
}
