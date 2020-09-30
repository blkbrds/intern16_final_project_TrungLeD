//
//  HomeViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    let searchBar = UISearchBar()
    var menu: SideMenuNavigationController?
    var inputDate: [Date] = []
    private var viewModel: HomeViewModel = HomeViewModel()
    
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
        viewModel.getAllData() { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    this.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                }
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
        let nib = UINib(nibName: "HomeTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "cellHome")
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

// MARK: UITableView Delegate, UITableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellHome = tableView.dequeueReusableCell(withIdentifier: "cellHome", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        cellHome.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cellHome
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSorts.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}

// MARK: Extension
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //        let booking = UIContextualAction(style: .normal, title: "Booking") { (action, view, completionHandle) in
    //
    //        }
    //    }
}

extension HomeViewController: UISearchBarDelegate {
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
            viewModel.dataSorts = viewModel.datas
        } else {
           viewModel.dataSorts =  viewModel.dataSorts.filter{($0.name?.contains(searchText) ?? false)}
        }
        tableView.reloadData()
    }
}
