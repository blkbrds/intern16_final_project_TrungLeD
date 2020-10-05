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
        title = "Favourites List"
        let removeALlItem = UIBarButtonItem(image: UIImage(named: "ic_favourite_remove"), style: .plain, target: self, action: #selector(removeAllItem))
        navigationItem.rightBarButtonItem = removeALlItem
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
// Extension
extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension FavouriteViewController: FavouriteTableViewCellDelegate {
    func favourite(at view: FavouritesTableViewCell, needPerforms action: FavouritesTableViewCell.Action) {
        switch action {
        case .unfavourite:
            break
        default:
            break
        }
    }
}
