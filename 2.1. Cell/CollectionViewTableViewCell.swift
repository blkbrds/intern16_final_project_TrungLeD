//
//  HomeTableViewCell.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

final class CollectionViewTableViewCell: UITableViewCell {
    
    // MARK: IBOutlet
    @IBOutlet weak var namePitch: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var timeActive: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var bookingButton: UIButton!
    @IBOutlet weak var dateBookingLabel: UILabel!
    
    // MARK: Properties
    var viewModel: CollectionViewCellViewModel? {
        didSet {
            updateView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Function
    private func updateView() {
        namePitch.text = viewModel?.name
        address.text = viewModel?.districtOwner
        dateBookingLabel.text = viewModel?.timeUser
        imageView1.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func bookingTapped(_ sender: UIButton) {
        
    }
}
