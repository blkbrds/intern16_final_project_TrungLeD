//
//  ImageDetailCell.swift
//  FinalProject
//
//  Created by Abcd on 9/28/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class ImageDetailCell: UITableViewCell {

    @IBOutlet weak var imageView1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func bookingTapped(_ sender: UIButton) {
        
    }
    @IBAction func locationTapped(_ sender: Any) {
    }
    
    @IBAction func favoriteTapped(_ sender: Any) {
        
    }
    
}
