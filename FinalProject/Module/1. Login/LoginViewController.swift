//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - IBoutlet
    
    @IBOutlet weak var containerViewSignIn: UIView!
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
        phoneTextField.layer.cornerRadius = 15
        passWordTextField.layer.cornerRadius = 15
        loginButton.styleHollowButton()
        containerViewSignIn.layer.cornerRadius = 25
        let color = UIColor.lightText
        let phoneHolder = phoneTextField.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        phoneTextField.attributedPlaceholder = NSAttributedString(string: phoneHolder, attributes: [NSAttributedString.Key.foregroundColor: color])
        let passHolder = passWordTextField.placeholder ?? "" //There should be a placeholder set in storyboard or elsewhere string or pass empty
        passWordTextField.attributedPlaceholder = NSAttributedString(string: passHolder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    // MARK: - IBAction
    @IBAction func loginPressed(_ sender: UIButton) {
        login()
    }
}

// MARK: - Extension
extension LoginViewController {
    private func login() {
        HUD.show()
        guard let phone = phoneTextField.text, let pw = passWordTextField.text else { return }
        viewModel.login(phone: phone, pw: pw) { [weak self] result  in
            HUD.popActivity()
            switch result {
            case .success:
                if self?.viewModel.login.message == "OK" {
                    AppDelegate.shared.changeRoot(rootType: .tabbar)
                } else {
                    self?.showAlert(alertText: App.Login.errorLogin, alertMessage: App.Login.messLogin)
                }
            case .failure(let error):
                self?.showAlert(alertText: App.Login.errorLogin, alertMessage: "\(App.Login.error)\(error)")
            }
        }
    }
}
