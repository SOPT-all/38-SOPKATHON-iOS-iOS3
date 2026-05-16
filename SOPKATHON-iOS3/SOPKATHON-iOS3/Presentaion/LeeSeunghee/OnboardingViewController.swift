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
    
    private let icon1 = UIImageView()
    
    private let icon2 = UIImageView()
    
    private let icon3 = UIImageView()
    
    private let icon4 = UIImageView()
    
    private let message1 = UIImageView()
    
    private let message2 = UIImageView()
    
    private let message3 = UIImageView()
    
    private let homeButton = CustomButton(type: .onboarding)
    
    override func setStyle() {
        view.backgroundColor = .white
        
        icon1.do {
            $0.image = .on1
        }
        
        icon2.do {
            $0.image = .on2
        }
        
        icon3.do {
            $0.image = .on3
        }
        
        icon4.do {
            $0.image = .on4
        }
        
        message1.do {
            $0.image = .onboarding1
        }
        
        message2.do {
            $0.image = .onboarding2
        }
        
        message3.do {
            $0.image = .onboarding3
        }
        
        homeButton.do {
            $0.delegate = self
        }
    }
    
    override func setUI() {
        view.addSubviews(icon1, icon2, icon3, icon4, message1, message2, message3, homeButton)
    }
    
    override func setLayout() {
        
        icon1.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(message1.snp.top).offset(-60)
        }

        icon2.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(message1.snp.bottom).offset(-10)
        }
        
        icon3.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalTo(message3.snp.bottom).offset(20)
        }
        
        icon4.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(message3.snp.bottom).offset(50)
        }
        
        message1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(207)
            $0.leading.equalToSuperview().inset(8)
            $0.width.equalTo(290)
            $0.height.equalTo(49)
        }
        
        message2.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(304)
            $0.trailing.equalToSuperview()
            $0.width.equalTo(318)
            $0.height.equalTo(49)
        }
        
        message3.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(404)
            $0.leading.equalToSuperview().inset(28)
            $0.width.equalTo(312)
            $0.height.equalTo(49)
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
//        let vc = ViewController()
//        navigationController?.pushViewController(vc, animated: true)
        
        //수민이거에 붙이기!!!
    }
}
