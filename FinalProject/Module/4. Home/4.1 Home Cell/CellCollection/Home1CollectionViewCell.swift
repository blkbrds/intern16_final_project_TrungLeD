//
//  Home1CollectionViewCell.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/2/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class Home1CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var namePitch: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var timeAction: UILabel!
    
    var viewModel: Home1CollectionCellModel? {
              didSet {
                  updateView()
              }
          }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updateView() {
        namePitch.text = viewModel?.namePitch
        address.text = viewModel?.address
        timeAction.text = viewModel?.timeAction
    }
}
