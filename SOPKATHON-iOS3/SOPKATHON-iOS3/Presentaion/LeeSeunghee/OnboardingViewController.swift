//
//  OnboardingViewController.swift
//  SOPKATHON-iOS3
//
//  Created by 초긍정행운의포춘쿠키 on 5/16/26.
//

import UIKit

import SnapKit
import Then

class OnboardingViewController: BaseUIViewController {
    
    private let message1 = UIImageView()
    
    private let message2 = UIImageView()
    
    private let message3 = UIImageView()
    
    private let homeButton = CustomButton(type: .onboarding)
    
    override func setStyle() {
        view.backgroundColor = .white
        
        
        homeButton.do {
            $0.delegate = self
        }
    }
    
    override func setUI() {
        view.addSubviews(message1, message2, message3, homeButton)
    }
    
    override func setLayout() {
        message1.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        message2.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        message3.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        homeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.width.equalTo(355)
            $0.height.equalTo(44)
        }
    }
}


extension OnboardingViewController: CustomButtonDelegate {
    func customButtonDidTap(_ button: CustomButton, type: CustomButtonType) {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
