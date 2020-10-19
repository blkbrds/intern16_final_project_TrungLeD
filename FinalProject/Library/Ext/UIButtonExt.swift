//
//  UIButtonExt.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/25/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
extension UIButton {
    
    // MARK: Function
    func drawColor() {
        self.backgroundColor = #colorLiteral(red: 0.737254902, green: 0.6980392157, blue: 0.5176470588, alpha: 1)
        self.layer.cornerRadius = 15.0
        self.tintColor = UIColor.white
    }
    func styleHollowButton() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 25.0
        self.tintColor = UIColor.black
    }
}
