//
//  ListPitchViewController.swift
//  FinalProject
//
//  Created by Trung Le D. on 9/17/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MapKit

class ListPitchViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet var mapKit: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationCurrentBtn: UIButton!
    @IBOutlet weak var datePicker1: UIDatePicker!
    @IBOutlet var viewContainerDatePicker: UIView!
    
    // MARK: - Properties
    var hidenDatePicker: Bool = false
    var pins: [MyPin] = []
    var inputDate: [Date] = []
    private var viewModel: ListPitchViewModel = ListPitchViewModel()
    var pitch: [Pitch]?
    var idPitch: Int = 0
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = .black
        nav?.tintColor = .white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        tableView.reloadData()
        //   viewModel.fetchRealmData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configureUI()
        mapView1()
        configSyncRealm()
        getData()
        addAnnotations()
        configMapView()
        configDatePicker()
    }
    // MARK: - Function DatePicker
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
        viewModel.bookingThePitch(date: date, idCustomer: 1, idPitch: idPitch, idPrice: 1, idTime: idTime) { [weak self] (result) in
            guard let this = self else { return }
            switch result {
            case .success:
                this.showAlert(alertText: "Đặt Sân", alertMessage: "Tình trạng: \(this.viewModel.resultBooking.status)")
            case .failure(let error):
                self?.showAlert(alertText: "loi dat san----", alertMessage: "loi dat san\(error)")
            }
        }
        stateDatePickerDefault()
    }
    
    // MARK: - Function
    func configSyncRealm() {
        viewModel.delegate = self
        viewModel.setupObserve()
    }
    
    // MARK: - get data for pin mapView
    func center(location: CLLocation) {
        //center
        mapKit.setCenter(location.coordinate, animated: true)
        //zoom
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapKit.setRegion(region, animated: true)
        //show current location
        mapKit.showsUserLocation = true
        //addAnnotation()
        mapKit.addAnnotations(pins)
    }
    
    @IBAction func getLocationCurrent(_ sender: UIButton) {
        LocationManager.shared().getCurrentLocation { (location) in
            self.center(location: location)
        }
    }
    
    func configMapView() {
        mapKit.delegate = self
        // This is coordinate of Da Nang city.
        let daNangLocation = CLLocation(latitude: 16.052_28, longitude: 108.191_942_6)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: daNangLocation.coordinate, span: span)
        mapKit.region = region
    }
    
    func getDataPin() {
        for i in 0..<viewModel.pitchTotals.count {
            let pin = MyPin(title: viewModel.pitchTotals[i].name,
                            locationName: viewModel.pitchTotals[i].address,
                            coordinate: CLLocationCoordinate2D(latitude: viewModel.pitchTotals[i].type.owner.lat, longitude: viewModel.pitchTotals[i].type.owner.lng))
            pins.append(pin)
        }
    }
    
    func addAnnotations() {
        mapKit.addAnnotations(pins)
    }
    
    func getData() {
        //   viewModel.fetchRealmData()
        loadData()
    }
    
    private func loadData() {
        viewModel.getAllData { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.tableView.reloadData()
                this.viewModel.setupObserve()
                this.getDataPin()
            case .failure(let error):
                this.showAlert(alertText: "Error", alertMessage: "error loadData \(error)")
            }
        }
    }
    
    // MARK: - Objc Function
    var leftItem = UIBarButtonItem()
    @objc private func mapView1() {
        leftItem = UIBarButtonItem(image: UIImage(named: "ic_listpitch_listview"), style: .plain, target: self, action: #selector(listView))
        leftItem.tintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.rightBarButtonItem = nil
        tableView.isHidden = true
        mapKit.isHidden = false
        locationCurrentBtn.isHidden = false
    }
    
    @objc private func listView() {
        locationCurrentBtn.isHidden = true
        let leftItem = UIBarButtonItem(image: UIImage(named: "ic_listpitch_map"), style: .plain, target: self, action: #selector(mapView1))
        leftItem.tintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
        let searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 100, height: 0))
        searchBar.placeholder = "Nhập Tên Sân"
        let rightNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        searchBar.searchTextField.textColor = .white
        searchBar.delegate = self
        tableView.isHidden = false
        mapKit.isHidden = true
    }
    
    // MARK: - Function
    private func configureUI() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func configTableView() {
        let nib = UINib(nibName: "ListPitchTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "ListPitchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - Func Load Date Picker
    //    let datePicker = Bundle.main.loadNibNamed("DatePickerUIView", owner: self, options: nil)?.first as? DatePickerUIView
    private func loadDatePicker() {
        UIView.animate(withDuration: 0.3, animations: {
            self.tabBarController?.tabBar.isHidden = true
            self.viewContainerDatePicker.isHidden = false
            self.tableView.alpha = 0.5
            self.tableView.allowsSelection = false
        })
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
        return viewModel.pitchs.count
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
      //  detailVC.hidesBottomBarWhenPushed = true
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
            viewModel.pitchs = viewModel.pitchTotals
        } else {
            viewModel.pitchs = viewModel.pitchs.filter { ($0.name.contains(searchText)) }
        }
        tableView.reloadData()
    }
}
// MARK: - Extension: - ListPitchTableViewCellDelegate
extension ListPitchViewController: ListPitchTableViewCellDelegate {
    func handleFavoriteTableView(cell: ListPitchTableViewCell, needPerform action: ListPitchTableViewCell.Action) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        switch action {
        case .favorite(let isFavorite):
            if isFavorite {
                viewModel.unfavorite(id: cell.viewModel?.id ?? 0) { [weak self] result in
                    guard let this = self else { return }
                    switch result {
                    case .success:
                        this.tableView.reloadData()
                    case.failure(let error):
                        this.showAlert(alertText: "Error favorite", alertMessage: "error From realm \(error)")
                    }
                }
            } else {
                viewModel.addFavorite(index: indexPath.row) { [weak self] result in
                    guard let this = self else { return }
                    switch result {
                    case .success:
                        this.tableView.reloadData()
                    case .failure(let error):
                        this.showAlert(alertText: "Error add favorite", alertMessage: "error From realm \(error)")
                    }
                }
            }
        }
    }
  
    func bookingButton(cell: ListPitchTableViewCell, id: Int) {
        loadDatePicker()
        idPitch = id

    func handleFavoriteTableView(cell: ListPitchTableViewCell, id: Int, isFavorite: Bool) {
        if isFavorite {
            viewModel.unfavorite(id: id)
        } else {
            viewModel.addFavorite(id: cell.viewModel?.id ?? 0,
                                  namePitch: cell.viewModel?.name ?? "",
                                  addressPitch: cell.viewModel?.addressOwner ?? "",
                                  timeUse: cell.viewModel?.timeUser ?? "",
                                  phone: cell.viewModel?.phoneOwner ?? "",
                                  pitchType: cell.viewModel?.pitchType ?? "",
                                  pitchImage: cell.viewModel?.imagePitch ?? "",
                                  description1: cell.viewModel?.description1 ?? "")
        }
        tableView.reloadData()
    }
}

// MARK: Extension: - ListPitchViewModelDelegate
extension ListPitchViewController: ListPitchViewModelDelegate {
    func syncFavorite(viewModel: ListPitchViewModel, needperformAction action: ListPitchViewModel.Action) {
        tableView.reloadData()
    }
}

// MARK: Extension: - MapView
extension ListPitchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MyPin else { return nil }
        let identifier = "mypin"
        var view: MyPinView
        if let dequeuedView = mapKit.dequeueReusableAnnotationView(withIdentifier: identifier) as? MyPinView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MyPinView(annotation: annotation, reuseIdentifier: identifier)
            // view.image = UIImage(named: "img_listpitch_pitch")
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "ic_listpitch_pin"))
            view.canShowCallout = true
        }
        return view
    }
}
