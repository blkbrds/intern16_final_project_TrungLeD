//
//  DatePickerTableViewCell.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/22/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: class {
    func didChangeDate(date: Date, indexPath: IndexPath)
}

class DatePickerTableViewCell: UITableViewCell {

    var indexPath: IndexPath?
    weak var delegate: DatePickerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //Cell height
    class func cellHeight() -> CGFloat {
        return 160
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView() {
          datePicker.addTarget(self, action: #selector(dateDidChange), for: .valueChanged)
      }
    
    func updateCell(date: Date, indexPath: IndexPath) {
        datePicker.setDate(date, animated: true)
        self.indexPath = indexPath
    }
    
    @objc func dateDidChange(_ sender: UIDatePicker) {
        if let indexPath = indexPath {
        let indexPathForDisplayDate = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        delegate?.didChangeDate(date: sender.date, indexPath: indexPathForDisplayDate)
    } else { return }
    }
}
