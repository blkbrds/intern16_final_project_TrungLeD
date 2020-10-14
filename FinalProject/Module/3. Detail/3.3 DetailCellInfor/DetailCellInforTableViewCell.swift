//
//  DetailCellInforTableViewCell.swift
//  FinalProject
//
//  Created by Abcd on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class DetailCellInforTableViewCell: UITableViewCell {
    // MARK: IBoutlet
    @IBOutlet weak var typePitchLabel: UILabel!
    @IBOutlet weak var inforPitch: UILabel!
    @IBOutlet weak var iconLabel: UIImageView!
    @IBOutlet weak var layoutBottom: NSLayoutConstraint!
    
    // MARK: Properties
    var viewModel: DetailInforCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Function
    func updateView() {
        if viewModel?.index == 0 {
        inforPitch.text = viewModel?.pitchType
            typePitchLabel.isHidden = true
            iconLabel.isHidden = true
            layoutBottom.constant = 10
        } else {
            layoutBottom.constant = 30
            typePitchLabel.isHidden = false
            iconLabel.isHidden = false
            inforPitch.text = ""
            inforPitch.isHidden = true
            typePitchLabel.text = viewModel?.pitchType
        }
    }
}
