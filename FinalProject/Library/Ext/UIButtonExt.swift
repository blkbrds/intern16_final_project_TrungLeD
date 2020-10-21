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
        self.backgroundColor = #colorLiteral(red: 0.2705882353, green: 0.2392156863, blue: 0.5647058824, alpha: 1)
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
