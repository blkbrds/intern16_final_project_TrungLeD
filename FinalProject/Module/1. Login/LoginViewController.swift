//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - IBoutlet
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Properties
    var viewModel: LoginViewModel = LoginViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    
    // MARK: - Function
    private func setupElements() {
        phoneTextField.drawLine()
        passWordTextField.drawLine()
        loginButton.drawColor()
        loginButton.styleHollowButton()
    }
    
    // MARK: - IBAction
    @IBAction func loginPressed(_ sender: UIButton) {
        login()
    }
}

// MARK: - Extension
extension LoginViewController {
    private func login() {
        guard let phone = phoneTextField.text, let pw = passWordTextField.text else { return }
        viewModel.login(phone: phone, pw: pw) { [weak self] result  in
            switch result {
            case .success:
                AppDelegate.shared.changeRoot(rootType: .tabbar)
            case .failure(let error):
                self?.showAlert(alertText: "Lỗi Đăng Nhập", alertMessage: "Nhập lại mật khẩu hoặc số điện thoại")
            }
        }
    }
}
