//
//  FavouritesTableViewCell.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/5/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
protocol FavouriteTableViewCellDelegate: class {
    func handleFavorite(cell: FavouritesTableViewCell, pitchID: Int, isFavorite: Bool)
}

class FavouritesTableViewCell: UITableViewCell {
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
        image1.layer.cornerRadius = 15
        namePitch.layer.cornerRadius = 15
        timeAction.layer.cornerRadius = 15
        address.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateView() {
        guard let viewModel = viewModel else { return }
        namePitch.text = viewModel.pitch.name
        timeAction.text = viewModel.pitch.timeUse
        address.text = viewModel.pitch.pitchType.owner.address
    }
    // MARK: - IBAction
    @IBAction func cancelFavourites(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        if let delegate = delegate {
            delegate.handleFavorite(cell: self, pitchID: viewModel.pitch.idPitch, isFavorite: viewModel.isFavorite)
        }
        updateView()
    }
    
    @IBAction func bookingClicked(_ sender: UIButton) {
    }
    
}
