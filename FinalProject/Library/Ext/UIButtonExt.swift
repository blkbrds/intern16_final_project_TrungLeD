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
        self.backgroundColor = UIColor(red: 48 / 255, green: 173 / 255, blue: 99 / 255, alpha: 1)
        self.layer.cornerRadius = 25.0
        self.tintColor = UIColor.white
    }
    func styleHollowButton() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 25.0
        self.tintColor = UIColor.black
    }
}
