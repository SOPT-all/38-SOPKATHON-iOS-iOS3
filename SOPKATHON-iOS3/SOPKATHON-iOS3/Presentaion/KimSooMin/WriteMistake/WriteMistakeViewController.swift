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
        UIView.animate(withDuration: 0.2) {
            self.bgDimmedImageView.alpha = 1
            self.mainView.alpha = 1
        }
    }
}

extension WriteMistakeViewController: WriteMistakeViewDelegate {
    
    func writeMistakeViewDidTapCancel(_ view: WriteMistakeView) {
        UIView.animate(withDuration: 0.2, animations: {
            self.bgDimmedImageView.alpha = 0
            self.mainView.alpha = 0
        }) { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func writeMistakeViewDidTapWrite(_ view: WriteMistakeView, title: String?, content: String?) {
        guard let title = title, !title.isEmpty,
              let content = content, !content.isEmpty else {
            print("입력값이 비어있습니다.")
            return
        }
        print("서버 전송 준비 완료 🚀 -> 제목: \(title), 내용: \(content)")
        
        // ⭐️ 성공적으로 작성 완료되었을 때도 모달이 부드럽게 사라지게 하려면 아래와 같이 처리할 수 있습니다.
        UIView.animate(withDuration: 0.2, animations: {
            self.bgDimmedImageView.alpha = 0
            self.mainView.alpha = 0
        }) { _ in
            self.dismiss(animated: false, completion: nil)
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
}

// MARK: - PHPickerViewControllerDelegate (사진 선택 완료 처리)

extension WriteMistakeViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let result = results.first else { return }
        let itemProvider = result.itemProvider
        
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                guard let self = self, let image = image as? UIImage, error == nil else { return }
                
                DispatchQueue.main.async {
                    self.mainView.updateSelectedImage(image)
                }
            }
        }
    }
}
