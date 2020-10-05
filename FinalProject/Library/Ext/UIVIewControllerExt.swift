//
//  UIViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/24/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(alertText: String, alertMessage: String) {
        let alert = UIAlertController(title: alertText,
                                      message: alertMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
