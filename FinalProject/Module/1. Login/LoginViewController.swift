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
        Utilities.styleTextFiend(phoneTextField)
        Utilities.styleTextFiend(passWordTextField)
        Utilities.styleFilledButton(loginButton)
        // Utilities.styleHollowButton(<#T##button: UIButton##UIButton#>)
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        login()
    }
}

extension LoginViewController {
    
    private func login() {
        guard let phone = phoneTextField.text, let pw = passWordTextField.text else { return }
        viewModel.login(phone: phone, pw: pw) { result in
            switch result {
            case .success:
                 AppDelegate.shared.changeRoot(rootType: .home)
            case .failure(let error):
                // Show alert, title, ok
                break
            }
            
        }
    }
}
