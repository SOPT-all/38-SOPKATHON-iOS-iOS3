//
//  ViewController.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

import UIKit

import SnapKit
import Then

class ViewController: BaseUIViewController {
    private let titleLabel = UILabel()

    override func setStyle() {
        view.backgroundColor = .yellow

        titleLabel.do {
            $0.font = .body_m_12
            $0.textColor = .black
            $0.text = "폰트 테스트"
        }
    }

    override func setUI() {
        view.addSubview(titleLabel)
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
