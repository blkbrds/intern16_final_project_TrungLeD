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
    @IBOutlet weak var addressPitchLabel: UILabel!
    @IBOutlet weak var iconLabel: UIImageView!
    
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
        if viewModel?.index == 0 {
            iconLabel.image = UIImage(named: "ic_detail_location")
            addressPitchLabel.text = viewModel?.address
        } else if viewModel?.index == 1 {
            addressPitchLabel.text = viewModel?.phoneNumber
            iconLabel.image = UIImage(named: "ic_detail_phone")
        } else {
            iconLabel.image = UIImage(named: "ic_detail_clock")
            addressPitchLabel.text = viewModel?.timeActive
        }
        
    }
}
