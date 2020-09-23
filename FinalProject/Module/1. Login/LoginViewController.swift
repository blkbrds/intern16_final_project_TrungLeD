//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
class LoginViewController: UIViewController {
    
    var viewModel = LoginViewModel()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
        
   // MARK: - Function
    private func setupElements() {
        Utilities.styleTextFiend(emailTextField)
        Utilities.styleTextFiend(passWordTextField)
        Utilities.styleFilledButton(loginButton)
        // Utilities.styleHollowButton(<#T##button: UIButton##UIButton#>)
    }
    
    func updateUI() {
        
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        viewModel.loadAPI { (done, message) in
            if done {
                print("Đăng Nhập Thành Công")
                self.updateUI()
                let appd = UIApplication.shared.connectedScenes.first
                if let app: AppDelegate = (appd?.delegate as? AppDelegate) {
                    app.changeRoot(rootType: .home)
                }
            } else {
                self.errorLabel.text = "Sai Tên Đăng Nhập Hoặc Mật Khẩu"
                print("Loi dang nhap: \(message)")
            }
        }
    }
}
