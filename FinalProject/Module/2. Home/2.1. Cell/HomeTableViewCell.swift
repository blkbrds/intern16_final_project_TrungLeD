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
class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var bookingButton: UIButton!
    @IBOutlet weak var dateBooking: UILabel!
    @IBOutlet weak var dateBookingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
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
        dateBookingLabel.text = text
        dateBooking.text = date.convertToString(dateFormat: .dateWithTime)
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
