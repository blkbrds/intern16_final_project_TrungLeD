//
//  DetailViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/29/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configtable()
    }
    
    // MARK: Function
    
    private func configtable() {
        let inforCell = UINib(nibName: "ImageDetailCell", bundle: Bundle.main)
        tableView.register(inforCell, forCellReuseIdentifier: "ImageDetailCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: Extension
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageDetailCell", for: indexPath) as? ImageDetailCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 224
        default:
            return UITableView.automaticDimension
        }
    }
}
