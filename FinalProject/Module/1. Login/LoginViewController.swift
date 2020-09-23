//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {
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
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
    }
}
