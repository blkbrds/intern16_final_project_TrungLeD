//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/16/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // MARK: - IBoutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    // MARK: - Function
    @IBAction func loginPressed(_ sender: UIButton) {
        
    }
    
}
