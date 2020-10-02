//
//  DetailCellInforTableViewCell.swift
//  FinalProject
//
//  Created by Abcd on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class DetailCellInforTableViewCell: UITableViewCell {

    @IBOutlet weak var typePitchLabel: UILabel!
    
    // MARK: Properties
      var viewModel: DetailInforCellViewModel? {
             didSet {
                 updateView()
             }
         }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateView() {
        typePitchLabel.text = viewModel?.pitchType
    }
}
