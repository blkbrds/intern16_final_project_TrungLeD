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
    
    var menu: SideMenuNavigationController?
    var inputDate: [Date] = []
    var datePickerIndexPath: IndexPath!
    private var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configSideMenu()
        configTableView()
        addInitValue()
    }
    
    func addInitValue() {
        inputDate = Array(repeating: Date(), count: viewModel.datas.count)
    }
    func configTableView() {
        let nib = UINib(nibName: "HomeTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "cellHome")
        let nib2 = UINib(nibName: "DatePickerTableViewCell", bundle: Bundle.main)
        tableView.register(nib2, forCellReuseIdentifier: "cellDatePicker")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func indexPathToInsertDatePicker(indexPath: IndexPath) -> IndexPath {
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row < indexPath.row {
            return indexPath
        } else {
            return IndexPath(row: indexPath.row + 1, section: indexPath.section)
        }
    }
    
    func configSideMenu() {
        let menu = SideMenuNavigationController(rootViewController: MenuListController(with: ["HOME", "COLLECTION", "SCHEDULE", "FAVORITES"]))
        menu.leftSide = true
         let leftItem = UIBarButtonItem(image: UIImage(systemName: "text.justify"), style: .plain, target: self, action: #selector(didTapMenu))
        leftItem.tintColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
        SideMenuManager.defaultManager.leftMenuNavigationController = menu
        SideMenuManager.defaultManager.addPanGestureToPresent(toView: self.view)
       
    }
    
    @objc func didTapMenu() {
        guard let menu = SideMenuManager.defaultManager.leftMenuNavigationController else { return }
        present(menu, animated: true)
    }
}

// MARK: Side Menu
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

// MARK: UITableView Delegate, UITableView DataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if datePickerIndexPath != nil {
            return viewModel.datas.count + 1
        } else {
            return viewModel.datas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if datePickerIndexPath == indexPath {
            guard let cellDatePicker = tableView.dequeueReusableCell(withIdentifier: "cellDatePicker", for: indexPath)
                as? DatePickerTableViewCell
                else {
                return UITableViewCell()
            }
            cellDatePicker.updateCell(date: inputDate[indexPath.row - 1], indexPath: indexPath)
   //         cellDatePicker.delegate = self
            return cellDatePicker
        } else {
            guard let cellHome = tableView.dequeueReusableCell(withIdentifier: "cellHome", for: indexPath) as? HomeTableViewCell else {
                return UITableViewCell()
            }
            return cellHome
        }
}
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        if let datePickerIndexPath = datePickerIndexPath, datePickerIndexPath.row - 1 == indexPath.row {
            tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            self.datePickerIndexPath = nil
        } else {
            if let datePickerIndexPath = datePickerIndexPath {
                tableView.deleteRows(at: [datePickerIndexPath], with: .fade)
            }
            datePickerIndexPath = indexPathToInsertDatePicker(indexPath: indexPath)
            tableView.insertRows(at: [datePickerIndexPath], with: .fade)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if datePickerIndexPath == indexPath {
            return DatePickerTableViewCell.cellHeight()
        } else {
            return DatePickerTableViewCell.cellHeight()
        }
    }
    
}
extension ViewController: DatePickerDelegate {
    
    func didChangeDate(date: Date, indexPath: IndexPath) {
       // inputDate[indexPath.row] = date
    //    tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
