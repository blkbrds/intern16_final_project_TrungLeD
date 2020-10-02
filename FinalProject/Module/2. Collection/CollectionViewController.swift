//
//  CollectionViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SideMenu

class CollectionViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    //    var datePicker = UIDatePicker()
    let searchBar = UISearchBar()
    var menu: SideMenuNavigationController?
    var inputDate: [Date] = []
    private var viewModel: CollectionViewModel = CollectionViewModel()
    var pitch: [Pitch]?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configSideMenu()
        configTableView()
        loadData()
        configureUI()
    }
    
    // MARK: Function
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
    @objc func handleShowSearchBar() {
        searchBar.placeholder = "Nhập Tên Sân"
        searchBar.becomeFirstResponder()
        search(shouldShow: true)
    }
    
    // MARK: - Helper Functions
    
    func configureUI() {
        view.backgroundColor = .white
        searchBar.delegate = self
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        showSearchBarButton(shouldShow: true)
    }
    
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    func configTableView() {
        let nib = UINib(nibName: "CollectionTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "cellCollection")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configSideMenu() {
        let menu = SideMenuNavigationController(rootViewController: MenuListController(with: ["HOME", "COLLECTION", "SCHEDULE", "FAVORITES"]))
        menu.leftSide = true
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: self, action: #selector(didTapMenu))
        leftItem.tintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
        SideMenuManager.defaultManager.leftMenuNavigationController = menu
        navigationController?.navigationBar.isHidden = false
        SideMenuManager.defaultManager.addPanGestureToPresent(toView: self.view)
        
    }
    
    @objc func didTapMenu() {
        guard let menu = SideMenuManager.defaultManager.leftMenuNavigationController else { return }
        present(menu, animated: true)
    }
    
    func loadDatePicker() {
        let datePicker = DatePickerViewController()
        self.present(datePicker, animated: true) {
            
        }
    }
    
    @objc func cancelClick() {
        view.resignFirstResponder()
    }
    
    @objc func doneClick() {
        
        self.view.endEditing(true)
        view.resignFirstResponder()
    }
}

// MARK: Side Menu
class MenuListController: UITableViewController {
    
    private var items: [String]
    init (with items: [String]) {
        self.items = items
        super.init( nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: Extension: UITableView DataSource
extension CollectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellCollection = tableView.dequeueReusableCell(withIdentifier: "cellCollection", for: indexPath) as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        cellCollection.delegate = self
        cellCollection.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cellCollection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tmpPitchData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: Extension: UITableView Delegate
extension CollectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel = viewModel.getInforPitch(at: indexPath)
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}

extension CollectionViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did begin..")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("Search bar editing did end..")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is \(searchText)")
        if searchText.isEmpty {
            viewModel.tmpPitchData = viewModel.pitchData
        } else {
            viewModel.tmpPitchData =  viewModel.tmpPitchData.filter{($0.name.contains(searchText) ?? false)}
        }
        tableView.reloadData()
    }
    
}

extension CollectionViewController: CollectionViewControllerDelegate {
    func bookingButton(view: CollectionTableViewCell) {
        loadDatePicker()
    }
}
