//
//  DetailViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: IBoutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var viewModel: DetailViewModel = DetailViewModel()
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    // MARK: Private Function
    
    private func configTableView() {
        let nibHeader = UINib(nibName: "DetailHeaderTableViewCell", bundle: Bundle.main)
        tableView.register(nibHeader, forCellReuseIdentifier: "cellHeader")
        let nibBody = UINib(nibName: "DetailBodyTableViewCell", bundle: Bundle.main)
        tableView.register(nibBody, forCellReuseIdentifier: "cellBody")
        let nibInfor = UINib(nibName: "DetailCellInforTableViewCell", bundle: Bundle.main)
        tableView.register(nibInfor, forCellReuseIdentifier: "cellInfor")
        let nibHistory = UINib(nibName: "DetailCellHistoryTableViewCell", bundle: Bundle.main)
        tableView.register(nibHistory, forCellReuseIdentifier: "cellHistory")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configNavi(){
        let backBtn = UIBarButtonItem(image: UIImage(named:"ic_detail_back"), style: .plain, target: self, action: #selector(backCollectVC))
        backBtn.tintColor = .orange
        navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc func backCollectVC() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: UITableViewDelegate
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numberOfsection = viewModel.typeSectionLoad(number: indexPath.section)
        switch numberOfsection {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader", for: indexPath) as? DetailHeaderTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .body:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellBody", for: indexPath) as? DetailBodyTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .infor:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellInfor", for: indexPath) as? DetailCellInforTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .history:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellHistory", for: indexPath) as? DetailCellHistoryTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        switch section {
        case 0:
            return 270
        case 1:
            return 130
        default:
            return 130
        }
    }
}
