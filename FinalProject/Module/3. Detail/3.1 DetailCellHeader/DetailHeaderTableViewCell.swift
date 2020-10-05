//
//  DetailHeaderTableViewCell.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {
    // MARK: Properties
    var viewModel: DetailHeaderCellViewModel = DetailHeaderCellViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
