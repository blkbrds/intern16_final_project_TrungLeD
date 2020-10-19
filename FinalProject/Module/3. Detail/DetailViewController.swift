//
//  DetailViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

// MARK: - Enum
enum Favorite {
    case favorite
    case unFavorite
}
class DetailViewController: UIViewController {
    // MARK: - IBoutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker1: UIDatePicker!
    @IBOutlet var viewContainerDatePicker: UIView!
    
    // MARK: Properties
    var hidenDatePicker: Bool = false
    var pitch: [Pitch]?
    var viewModel: DetailViewModel = DetailViewModel(pitch: Pitch())
    var rightButton: UIBarButtonItem?
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        if viewModel.pitch.id != 0 {
            viewModel.updateFavorite()
        }
        if viewModel.isFavorite {
            rightButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favouriteClicked))
            navigationItem.rightBarButtonItem = rightButton
        } else {
            rightButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favouriteClicked))
            navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configNavi()
        configDatePicker()
    }
    // MARK: - Function for DatePicker
    private func loadDatePicker() {
        UIView.animate(withDuration: 0.3, animations: {
            self.tabBarController?.tabBar.isHidden = true
            self.viewContainerDatePicker.isHidden = false
            self.tableView.alpha = 0.5
            self.tableView.allowsSelection = false
        })
    }
    
    private func configDatePicker() {
        viewContainerDatePicker.isHidden = true
        datePicker1.minimumDate = Date()
    }
    
    private func stateDatePickerDefault() {
        UIView.transition(with: viewContainerDatePicker, duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.tabBarController?.tabBar.isHidden = false
                            self.viewContainerDatePicker.isHidden = true
                            self.tableView.alpha = 1
                            self.tableView.allowsSelection = true
        })
        
    }
    
    // MARK: - Function Check Time
    func checkTime() -> Int {
        let hour = datePicker1.date.getTime().hour
        let minute = datePicker1.date.getTime().minute
        if hour < 6 && hour > 22 {
            showAlert(alertText: "Sai khung giờ", alertMessage: "Chọn lại khung giờ")
            return 0 } else if  hour == 6 && minute == 30 {
            return 1
        } else if  hour == 7 && minute == 30 {
            return 2
        } else if  hour == 8 && minute == 30 {
            return 3 } else if  hour == 9 && minute == 30 {
            return 4 } else if  hour == 10 && minute == 30 {
            return 5 } else if  hour == 11 && minute == 30 {
            return 6 } else if  hour == 12 && minute == 30 {
            return 7 } else if  hour == 13 && minute == 30 {
            return 8 } else if  hour == 14 && minute == 30 {
            return 9 } else if  hour == 15 && minute == 30 {
            return 10 } else if  hour == 16 && minute == 30 {
            return 11 } else if  hour == 17 && minute == 30 {
            return 12 } else if  hour == 18 && minute == 30 {
            return 13 } else if  hour == 19 && minute == 30 {
            return 14 } else if  hour == 20 && minute == 30 {
            return 15 } else if minute == 0 { showAlert(alertText: "Sai Khung giờ", alertMessage: "Chọn Lại Giờ")
            return 0
        } else { return 0 }
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        stateDatePickerDefault()
    }
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        let idTime = checkTime()
        if idTime == 0 {
            showAlert(alertText: "Lỗi", alertMessage: "Vui lòng chọn trước 9h tối và sau 6h sáng")
        }
        let date = String(datePicker1.date.getDate())
        let dateCurrent = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: dateCurrent)
        if formattedDate == date {
            showAlert(alertText: "Lỗi", alertMessage: "Vui lòng đặt trước ít nhất 1 ngày")
        }
        viewModel.bookingThePitch(date: date, idCustomer: 1, idPitch: viewModel.pitch.id, idPrice: 1, idTime: idTime) { [weak self] (result) in
            HUD.show()
            guard let this = self else { return }
            switch result {
            case .success:
                this.showAlert(alertText: "Đặt Sân", alertMessage: "Tình trạng: \(this.viewModel.resultBooking.status)")
            case .failure(let error):
                self?.showAlert(alertText: "Lỗi Đặt Sân", alertMessage: "Lỗi Đặt Sân\(error)")
            }
            HUD.popActivity()
        }
        stateDatePickerDefault()
    }
    // MARK: - Private Function
    private func configTableView() {
        let customHeader = UINib(nibName: "CustomHeader", bundle: Bundle.main)
        tableView.register(customHeader, forHeaderFooterViewReuseIdentifier: "CustomHeader")
        let nibHeader = UINib(nibName: "DetailHeaderTableViewCell", bundle: Bundle.main)
        tableView.register(nibHeader, forCellReuseIdentifier: "cellHeader")
        let nibBody = UINib(nibName: "DetailBodyTableViewCell", bundle: Bundle.main)
        tableView.register(nibBody, forCellReuseIdentifier: "cellAdressBody")
        let nibInfor = UINib(nibName: "DetailCellInforTableViewCell", bundle: Bundle.main)
        tableView.register(nibInfor, forCellReuseIdentifier: "cellInfor")
        let nibHistory = UINib(nibName: "DetailCellHistoryTableViewCell", bundle: Bundle.main)
        tableView.register(nibHistory, forCellReuseIdentifier: "cellHistory")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configNavi() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.737254902, green: 0.6980392157, blue: 0.5176470588, alpha: 1)
        let backBtn = UIBarButtonItem(image: UIImage(named: "ic_detail_back1"), style: .plain, target: self, action: #selector(backListVC))
        backBtn.tintColor = .orange
        navigationItem.leftBarButtonItem = backBtn
        let isFavorite = viewModel.checkFavorite()
        if isFavorite {
            rightButton = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favouriteClicked))
            navigationItem.rightBarButtonItem = rightButton
        } else {
            rightButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favouriteClicked))
            navigationItem.rightBarButtonItem = rightButton
        }
    }
    
    @objc func favouriteClicked() {
        if !viewModel.checkFavorite() {
            if let error = viewModel.addFavorite() {
                showAlert(alertText: error.localizedDescription, alertMessage: "")
            }
            rightButton?.image = UIImage(systemName: "heart.fill")
        } else {
            if let error = viewModel.unfavorite() {
                showAlert(alertText: error.localizedDescription, alertMessage: "")
            }
            rightButton?.image = UIImage(systemName: "heart")
        }
    }
    
    @objc func backListVC() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 5
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let nib2 = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as? CustomHeader else { return UIView() }
        if section == 0 {
            nib2.titleLabel.text = "Bản Đồ"
            nib2.verifyIcon.isHidden = true
        }
        if section == 1 {
            nib2.titleLabel.text = viewModel.pitch.name
        }
        if section == 2 {
            nib2.titleLabel.text = "Thông Tin"
            nib2.verifyIcon.isHidden = true
        }
        if section == 3 {
            nib2.verifyIcon.isHidden = true
            nib2.titleLabel.text = "250.000 VND - 300.000 VND"
        }
        return nib2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let numberOfsection = viewModel.typeSectionLoad(number: indexPath.section)
        print(indexPath.section)
        switch numberOfsection {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader", for: indexPath) as? DetailHeaderTableViewCell else {
                return UITableViewCell()
            }   
            cell.viewModel = viewModel.viewModelForHeaderCell(at: indexPath)
            cell.delegate = self
            return cell
        case .body:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellAdressBody", for: indexPath) as? DetailBodyTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForBody(at: indexPath)
            return cell
        case .infor:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellInfor", for: indexPath) as? DetailCellInforTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForInfor(at: indexPath)
            return cell
        case .history:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellHistory", for: indexPath) as? DetailCellHistoryTableViewCell else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel.viewModelForHistory(at: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        switch section {
        case 0:
            return 270
        case 1:
            return 48
        case 2:
            return UITableView.automaticDimension
        default:
            return 40
        }
    }
}

// MARK: - Extension Detail Cell Header
extension DetailViewController: DetailHeaderTableViewCellDelegate {
    func bookingPitch(cell: DetailHeaderTableViewCell) {
        loadDatePicker()
    }
}
