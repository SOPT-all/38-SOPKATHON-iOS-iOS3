//
//  BaseUIView.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

import UIKit

class BaseUIView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setStyle()
        setUI()
        setLayout()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Methods
    
    func setStyle() {}
    
    func setUI() {}
    
    func setLayout() {}
    
    func setDelegate() {}
}
