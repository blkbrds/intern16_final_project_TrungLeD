//
//  DetailCellHistoryTableViewCell.swift
//  FinalProject
//
//  Created by Abcd on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class DetailCellHistoryTableViewCell: UITableViewCell {

    // MARK: Iboutlet
    @IBOutlet weak var description1: UILabel!
    
    // MARK: Properties
         var viewModel: DetailHistoryViewModel? {
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
    
    func updateView() {
        description1.text = viewModel?.description
    }
}
