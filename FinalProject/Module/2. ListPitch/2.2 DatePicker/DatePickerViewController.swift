//
//  DatePickerViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
    }
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
         dismiss(animated: true, completion: nil)
    }
}
