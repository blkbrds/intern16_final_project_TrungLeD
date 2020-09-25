//
//  UITextFieldExt.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/25/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
extension UITextField {
    func drawLine(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor(red: 48 / 255, green: 173 / 255, blue: 99 / 255, alpha: 1).cgColor
        self.layer.addSublayer(bottomLine)
    }
}
