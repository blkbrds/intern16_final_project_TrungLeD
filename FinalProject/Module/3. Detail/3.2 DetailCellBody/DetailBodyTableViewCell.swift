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
    
    //
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
