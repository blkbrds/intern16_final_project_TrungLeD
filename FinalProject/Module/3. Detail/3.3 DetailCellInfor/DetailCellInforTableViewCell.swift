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
        typePitchLabel.text = viewModel?.pitchType
    }
}
