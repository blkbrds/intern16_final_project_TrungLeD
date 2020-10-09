//
//  DatePickerUIView.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/9/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
protocol DatePickerUIViewDelegate: class {
    func handleButtonToolbar(at: DatePickerUIView, needPerform action: DatePickerUIView.Action)
}
class DatePickerUIView: UIView {
    // Enum
    enum Action {
        case done
        case cancel
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var datepick1: UIDatePicker!
    // MARK: - Properties
    weak var delegate: DatePickerUIViewDelegate?
    
    // MARK: - Function
    @IBAction func cancelTapped(_ sender: Any) {
        delegate?.handleButtonToolbar(at: self, needPerform: .cancel)
    }
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        getDataFromDatePicker()
        delegate?.handleButtonToolbar(at: self, needPerform: .done)
    }
    
    override init (frame: CGRect) {
        super.init(frame: frame)
//        datepick1.minimumDate = Date()
    }
    
    override func awakeFromNib() {
        datepick1.minimumDate = Date()
    }
    
    func getDataFromDatePicker() {
        var dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
   //     print(dateFormat.string(from: self))
    }
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
