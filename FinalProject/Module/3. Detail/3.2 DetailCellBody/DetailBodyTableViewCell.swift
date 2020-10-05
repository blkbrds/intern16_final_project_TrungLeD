//
//  DetailBodyTableViewCell.swift
//  FinalProject
//
//  Created by Abcd on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class DetailBodyTableViewCell: UITableViewCell {
    // MARK: IBOutlet
    @IBOutlet weak var namePitchLabel: UILabel!
    @IBOutlet weak var addressPitchLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var timeActiveLabel: UILabel!
    
    // MARK: Properties
    var viewModel: DetailBodyCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Function
    private func updateView() {
        namePitchLabel.text = viewModel?.namePitch
        addressPitchLabel.text = viewModel?.address
        phoneLabel.text = viewModel?.phoneNumber
        timeActiveLabel.text = viewModel?.timeActive
    }
}
