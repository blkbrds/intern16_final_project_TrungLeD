//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
    
    // MARK: - Function
    private func setupElements() {
        errorLabel.isHidden = true
        phoneTextField.drawLine()
        passWordTextField.drawLine()
        loginButton.drawColor()
        loginButton.styleHollowButton()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        login()
    }
}

    // MARK: - Extension
extension LoginViewController {
    
    private func login() {
        guard let phone = phoneTextField.text, let pw = passWordTextField.text else { return }
        viewModel.login(phone: phone, pw: pw) { result in
            switch result {
            case .success:
                AppDelegate.shared.changeRoot(rootType: .tabbar)
            case .failure(let error):
                print(error)
                self.errorLabel.isHidden = false
                self.errorLabel.text = "Sai thông tin đăng nhập"
                self.showAlert(alertText: "Lỗi Đăng Nhập", alertMessage: "Nhập lại mật khẩu hoặc số điện thoại")
            }
        }
    }
}
