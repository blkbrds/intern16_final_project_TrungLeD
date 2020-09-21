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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
    }
        
   // MARK: - Function
    private func setupElements() {
        Utilities.styleTextField(passWordTextField)
        Utilities.styleTextField(emailTextField)
//        Utilities.styleFilledButton(loginButton)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
          // TODO: Validate Text Fields
          
          // Create cleaned versions of the text field
          let email = emailTextField.text
          let password = passWordTextField.text
          
          // Signing in the user
        Auth.auth().signIn(withEmail: email ?? "", password: password ?? "") { ( result, error ) in
            if error != nil {
                print("error")
              }
              else {
                  let homevc = HomeViewController()
                var window: UIWindow?
                window?.rootViewController = homevc
                window?.makeKeyAndVisible()
              }
          }
    }
    
}
