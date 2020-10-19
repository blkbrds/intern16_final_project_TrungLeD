//
//  UITextFieldExt.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/25/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
extension UITextField {
    
    // MARK: Function
    func drawLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 2, width: self.frame.width, height: 2)
        bottomLine.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.6980392157, blue: 0.5176470588, alpha: 1)
        self.layer.addSublayer(bottomLine)
    }
}
