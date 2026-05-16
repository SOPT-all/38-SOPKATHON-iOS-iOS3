//
//  BaseUIViewController.swift
//  SOPKATHON--iOS3
//
//  Created by mandoo on 5/16/26.
//

import UIKit

class BaseUIViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUI()
        setStyle()
        setLayout()
        setAddTarget()
        setDelegate()
        
        hideKeyboardWhenTappedAround()
        navigationItem.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Custom Methods
    
    func setStyle() {}
    
    func setUI() {}
    
    func setLayout() {}
    
    // MARK: - Action Method
    
    func setAddTarget() {}
    
    // MARK: - delegate Method
    
    func setDelegate() {}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
