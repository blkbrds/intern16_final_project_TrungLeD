//
//  HomeTableViewCell.swift
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
final class HomeTableViewCell: UITableViewCell {
    
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
    var viewModel: HomeCellViewModel? {
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
    
    class func cellHeight() -> CGFloat {
        return 100
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func bookingTapped(_ sender: UIButton) {
        
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
