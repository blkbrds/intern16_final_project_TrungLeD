//
//  ListPitchTableViewCell.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
enum DateFormatType: String {
    
    // Time
    case time = "HH:mm"
    
    //Date with hours
    case dateWithTime = "dd-mm-yyyy HH:mm"
    
    //Date
    case date = "dd-MM-yyyy"
}
protocol ListPitchViewControllerDelegate {
    func bookingButton(view: ListPitchTableViewCell)
}
final class ListPitchTableViewCell: UITableViewCell {
    
    // MARK: IBOutlet
    @IBOutlet weak var namePitch: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var bookingButton: UIButton!
    @IBOutlet weak var dateBookingLabel: UILabel!
    
    // MARK: Properties
    var delegate: ListPitchViewControllerDelegate?
    var pitch: [Pitch]?
    var viewModel: ListPitchCellViewModel? {
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
        address.text = viewModel?.addressOwner
        dateBookingLabel.text = viewModel?.timeUser
        imageView1.layer.cornerRadius = 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func bookingTapped(_ sender: UIButton) {
        delegate?.bookingButton(view: self)
    }
    
    func updateText(text: String, date: Date) {
        dateBookingLabel.text = date.convertToString(dateFormat: .dateWithTime)
    }
    
}

extension Date {
    func convertToString(dateFormat formatType: DateFormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.rawValue
        let newDate: String = dateFormatter.string(from: self)
        return newDate
    }
}