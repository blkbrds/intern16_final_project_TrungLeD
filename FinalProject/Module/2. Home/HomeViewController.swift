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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configSideMenu()
        configTableView()
    }
    
    func configTableView() {
        let nib = UINib(nibName: "HomeTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "cellHome")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configSideMenu() {
        let leftItem = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: self, action: #selector(didTapMenu))
        leftItem.tintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
    }
    
    @objc func didTapMenu() {
        guard let menu = SideMenuManager.defaultManager.leftMenuNavigationController else { return }
        present(menu, animated: true)
    }

}

class MenuListController: UITableViewController {
    
    private var darkColor = UIColor(red: 33 / 255, green: 33 / 255, blue: 33 / 255, alpha: 1)
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellHome", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
