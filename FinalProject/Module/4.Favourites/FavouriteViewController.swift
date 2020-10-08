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
    @IBOutlet weak var notificationLabel: UILabel!
    
    // MARK: - Properties
    var viewModel = FavouriteViewModel()
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = .black
        nav?.tintColor = .white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavi()
        configTableView()
        fectchData()
        configSyncRealmData()
    }
    
    // MARK: Function
    private func configSyncRealmData() {
        viewModel.delegate = self
    }
    
    private func checkFavoriteData() {
        viewModel.checkFavoriteData { [weak self] (done) in
            guard let this = self else { return }
            if done {
                this.notificationLabel.isHidden = false
                this.notificationLabel.text = "No Favorite Pitch!"
            } else {
                this.notificationLabel.isHidden = true
            }
        }
    }
    
    func configTableView() {
        let nib = UINib(nibName: "FavouritesTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "FavouritesTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fectchData() {
        viewModel.fetchRealmData { [weak self] (done) in
            guard let this = self else { return }
            if done {
                this.checkFavoriteData()
                this.tableView.reloadData()
            } else {
                this.showAlert(alertText: "Error Get Data", alertMessage: "error data from realm")
            }
        }
    }
    
    func configNavi() {
        navigationItem.title = "Favorite List"
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteTouchUpInSide))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func deleteItemFavorite(id: Int) {
        viewModel.deleteItemFavorite(id: id) { [weak self] (done) in
            guard let this = self else { return }
            if done {
                this.fectchData()
                this.tableView.reloadData()
            } else {
                print("Delete error")
            }
        }
    }
    
    private func deleteAllItem() {
        viewModel.deleteAllItem { [weak self] (done) in
            guard let this = self else { return }
            if done {
                this.fectchData()
                this.tableView.reloadData()
            } else {
                print("Delete failed")
            }
        }
    }
    
    // MARK: - Objc Function
    @objc func deleteTouchUpInSide() {
        let alert = UIAlertController(title: "Warning", message: "Delete all", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .destructive) { [weak self] (_) in
            guard let this = self else { return }
            this.deleteAllItem()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension
extension FavouriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesTableViewCell", for: indexPath) as? FavouritesTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.viewModel = viewModel.cellForRowAt(indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.viewModel = viewModel.didSelectRowAt(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavouriteViewController: FavouriteViewModelDelegate {
    func favourite(viewModel: FavouriteViewModel, needPerform action: FavouriteViewModel.Action) {
        fectchData()
    }
}

extension FavouriteViewController: FavouriteTableViewCellDelegate {
    func handleFavorite(cell: FavouritesTableViewCell, id: Int, isFavorite: Bool) {
        deleteItemFavorite(id: id)
    }
}

