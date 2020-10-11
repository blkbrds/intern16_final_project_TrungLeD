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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notification: UILabel!
    
    // MARK: - Properties
    var viewModel: ScheduleViewModel = ScheduleViewModel()
    let refreshControl = UIRefreshControl()
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notification.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configTableView()
    }
    
    // MARK: - Function
    private func loadData() {
        viewModel.getReserver { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.showAlert(alertText: "Loi", alertMessage: "Loi\(error)")
            }
        }
        
        // MARK: - Result cancel
        viewModel.cancelReserver(idReserve: 130) { [weak self](result) in
            guard let this = self else { return }
            switch result {
            case .failure(let error):
                this.showAlert(alertText: "loi", alertMessage: "\(error)")
            case .success:
                print(result)
            }
        }
    }
    
    private func checkEmptyReserver() {
        viewModel.checkIsEmptyReserver { [weak self] (done) in
            guard let this = self else { return }
            if done {
                this.notification.isHidden = false
                this.notification.text = "No Reserver Pitch!"
            } else {
                this.notification.isHidden = true
            }
        }
    }
    
    @objc func pullToRefresh() {
        loadData()
        self.tableView.refreshControl?.endRefreshing()
        checkEmptyReserver()
    }
    
    func configTableView() {
        let nib = UINib(nibName: "ScheduleCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "ScheduleCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = UIRefreshControl()
        refreshControl.tintColor = .green
        tableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.reloadData()
    }
}
// MARK: - Extension
extension ScheduleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberRowOfSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as? ScheduleCell else { return UITableViewCell() }
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cancel = cancelAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [cancel])
    }
    
    func cancelAction(at indexPath: IndexPath) -> UIContextualAction {
        let listReserver = viewModel.reseverTotals[indexPath.row]
        let actionCancel = UIContextualAction(style: .normal, title: "Cancel") { (action, view, completion) in
            print("trung ngu ngok")
            completion(true)
        }
        actionCancel.image = UIImage(named: "ic_schedule_cancel")
        actionCancel.backgroundColor = .red
        return actionCancel
    }
}
