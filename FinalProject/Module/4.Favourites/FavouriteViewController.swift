//
//  FavouriteViewController.swift
//  FinalProject
//
//  Created by Abcd on 10/3/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import RealmSwift

final class FavouriteViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel = FavouriteViewModel()
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavi()
        configTableView()
    }
    
    // MARK: Function
    func configTableView() {
        let nib = UINib(nibName: "FavouritesTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "FavouritesTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configNavi() {
        let leftBarButton = UIBarButtonItem(image: UIImage(named: "ic-back"), style: .plain, target: self, action: #selector(backTouchUpInSide))
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteTouchUpInSide))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
//    private func deleteAllItem() {
//          viewModel.deleteAllItem { [weak self] (done) in
//              guard let this = self else { return }
//              if done {
//                  this.fectchData()
//              } else {
//                  print("Delete failed")
//              }
//          }
//      }
    
    @objc func deleteTouchUpInSide() {
        let alert = UIAlertController(title: "Warning", message: "Delete all", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive) { [weak self] (_) in
            guard let this = self else { return }
         //   this.deleteAllItem()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    @objc func backTouchUpInSide() {
        
    }
    func getDataFromRealm() {
        viewModel.getDataFromRealm { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                this.showAlert(alertText: "loi roi", alertMessage: "loi: \(error)")
            }
        }
    }
    // MARK: - Objc func
    @objc func removeAllItem() {
        let showAlert = UIAlertController(title: "Xóa Tất Cả", message: "bạn có muốn xóa hết không?", preferredStyle: .alert)
        showAlert.addAction(UIAlertAction(title: "Có", style: .default, handler: { (result) in
            self.viewModel.removeAllItem { [weak self] (result) in
                guard let this = self else { return }
                switch result {
                case .success:
                    this.getDataFromRealm()
                case .failure(let error):
                    this.showAlert(alertText: "loi", alertMessage: "text:\(error)")
                }
            }
        }))
    }
}
// MARK: - Extension
extension FavouriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
