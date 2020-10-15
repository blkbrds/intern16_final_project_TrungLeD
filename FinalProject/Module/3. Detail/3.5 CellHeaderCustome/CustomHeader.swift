//
//  CustomHeader.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/13/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    // MAKR: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var verifyIcon: UIImageView!
    
    // MARK: - Properties
    var viewModel = CustomHeaderViewModel() {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        titleLabel?.text = viewModel.title
        verifyIcon.isHidden = false
    }
}
