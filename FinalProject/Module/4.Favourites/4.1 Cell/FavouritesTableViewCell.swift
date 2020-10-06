//
//  FavouritesTableViewCell.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/5/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
protocol FavouriteTableViewCellDelegate: class {
    func favourite(at view: FavouritesTableViewCell, needPerforms action: FavouritesTableViewCell.Action)
}

class FavouritesTableViewCell: UITableViewCell {
    // MARK: - Enum
    enum Action {
        case unfavourite
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var namePitch: UILabel!
    @IBOutlet weak var timeAction: UILabel!
    @IBOutlet weak var address: UILabel!
    
    // MARK: - Properties
    weak var delegate: FavouriteTableViewCellDelegate?
    var viewModel: FavouriteCellViewModel? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateView() {
        image1.layer.cornerRadius = 2.5
        namePitch.text = viewModel?.pitch.name
        timeAction.text = viewModel?.pitch.timeUse
        address.text = viewModel?.pitch.pitchType.owner.address
    }
    // MARK: - IBAction
    @IBAction func cancelFavourites(_ sender: UIButton) {
        delegate?.favourite(at: self, needPerforms: .unfavourite)
    }
    
    @IBAction func bookingClicked(_ sender: UIButton) {
    }
    
}
