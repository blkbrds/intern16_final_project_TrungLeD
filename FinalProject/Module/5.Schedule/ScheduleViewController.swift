//
//  ScheduleViewController.swift
//  FinalProject
//
//  Created by Abcd on 10/3/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    // MARK: - IBoutlet

    // MARK: - Properties
    var viewModel: ScheduleViewModel = ScheduleViewModel()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Function
    private func loadData() {
        viewModel.getReserver { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .success:
                print("thanh cong")
            case .failure(let error):
                this.showAlert(alertText: "Loi", alertMessage: "Loi\(error)")
            }
        }
    }
    
}
