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
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.6950495243, green: 0.6684789658, blue: 0.547100842, alpha: 1)
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
                this.notificationLabel.text = App.Favorite.noFavorite
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
                this.showAlert(alertText: App.String.error, alertMessage: App.String.error)
            }
        }
    }
    
    func configNavi() {
        navigationItem.title = App.Favorite.title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
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
                this.showAlert(alertText: App.String.error, alertMessage: App.String.error)
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
                this.showAlert(alertText: App.String.error, alertMessage: App.String.error)
            }
        }
    }

    // MARK: - Objc Function
    @objc func deleteTouchUpInSide() {
        let alert = UIAlertController(title: App.Favorite.warningDelete, message: App.Favorite.deleteAll, preferredStyle: .alert)
        let okAction = UIAlertAction(title: App.String.ok, style: .destructive) { [weak self] (_) in
            guard let this = self else { return }
            this.deleteAllItem()
        }
        let cancelAction = UIAlertAction(title: App.String.cancel, style: .cancel)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.viewModel = viewModel.didSelectRowAt(indexPath: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavouriteViewController: FavouriteViewModelDelegate {
    func favourite(viewModel: FavouriteViewModel, needPerform action: FavouriteViewModel.Action) {
        switch action {
        case .loadData:
            fectchData()
        case .failure(let error):
            self.showAlert(alertText: App.String.error, alertMessage: "\(App.String.error): \(error)")
        }
    }
}

extension FavouriteViewController: FavouriteTableViewCellDelegate {
    func handleFavorite(cell: FavouritesTableViewCell, id: Int, isFavorite: Bool) {
        deleteItemFavorite(id: id)
    }
}
