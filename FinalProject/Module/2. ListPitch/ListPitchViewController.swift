//
//  ListPitchViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class ListPitchViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    var inputDate: [Date] = []
    private var viewModel: ListPitchViewModel = ListPitchViewModel()
    var pitch: [Pitch]?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        loadData()
        configureUI()
    }
    
    // MARK: - Function
    private func loadData() {
        viewModel.getAllData { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Helper Functions
    func configureUI() {
        let searchBar1: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 35, height: 0))
        searchBar1.placeholder = "Nhập Tên Sân"
        let leftNavBarButton = UIBarButtonItem(customView: searchBar1)
        self.navigationItem.rightBarButtonItem = leftNavBarButton
        view.backgroundColor = .white
        searchBar1.delegate = self
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func configTableView() {
        let nib = UINib(nibName: "ListPitchTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "ListPitchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadDatePicker() {
        let datePicker = DatePickerViewController()
        self.present(datePicker, animated: true) {
        }
    }
}

// MARK: Extension: - UITableView DataSource
extension ListPitchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellListPitch = tableView.dequeueReusableCell(withIdentifier: "ListPitchTableViewCell", for: indexPath) as? ListPitchTableViewCell else {
            return UITableViewCell()
        }
        cellListPitch.delegate = self
        cellListPitch.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cellListPitch
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tmpPitchData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: Extension: - UITableView Delegate
extension ListPitchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel = viewModel.getInforPitch(at: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ListPitchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did begin..")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did end..")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is \(searchText)")
        if searchText.isEmpty {
            viewModel.tmpPitchData = viewModel.pitchData
        } else {
            viewModel.tmpPitchData = viewModel.tmpPitchData.filter { ($0.name.contains(searchText)) }
        }
        tableView.reloadData()
    }
}

extension ListPitchViewController: ListPitchViewControllerDelegate {
    func bookingButton(view: ListPitchTableViewCell) {
        loadDatePicker()
    }
}
