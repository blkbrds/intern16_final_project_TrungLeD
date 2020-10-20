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
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet var viewContainerDatePicker: UIView!
    
    // MARK: - Properties
    var index: Int = 1
    var pins: [MyPin] = []
    var inputDate: [Date] = []
    private var viewModel: ListPitchViewModel = ListPitchViewModel()
    var pitch: [Pitch]?
    var leftItem = UIBarButtonItem()
    var idPitch: Int = 0
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        changeScreenMapTapped()
        configSyncRealm()
        getData()
        addAnnotations()
        configMapView()
        configDatePicker()
    }
    // MARK: - Function DatePicker
    private func configDatePicker() {
        viewContainerDatePicker.isHidden = true
        datePicker.minimumDate = Date()
    }
    
    private func stateDatePickerDefault() {
        UIView.transition(with: viewContainerDatePicker, duration: 1,
                          options: .transitionCurlUp,
                          animations: {
                            self.tabBarController?.tabBar.isHidden = false
                            self.viewContainerDatePicker.isHidden = true
                            self.tableView.alpha = 1
                            self.tableView.allowsSelection = true
        })
    }
    
    // MARK: - Function Check Time
    func checkTime() -> Int {
        let hour = datePicker.date.getTime().hour
        let minute = datePicker.date.getTime().minute
        if hour < 6 && hour > 22 {
            return 0 } else if  hour == 6 && minute == 30 {
            return 1 } else if  hour == 7 && minute == 30 {
            return 2 } else if  hour == 8 && minute == 30 {
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
            return 15 } else if minute == 0 { showAlert(alertText: App.ErrorBooking.errorTime, alertMessage: App.ErrorBooking.chooseTime)
            return 0 } else { return -1 }
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        stateDatePickerDefault()
    }
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        let idTime = checkTime()
        if idTime == 0 || idTime == -1 {
            showAlert(alertText: App.ErrorBooking.errorInforBooking, alertMessage: App.ErrorBooking.minHours)
        }
        let date = String(datePicker.date.getDate())
        let dateCurrent = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: dateCurrent)
        if formattedDate == date {
            showAlert(alertText: App.ErrorBooking.errorInforBooking, alertMessage: App.ErrorBooking.minDay)
        }
        viewModel.bookingThePitch(date: date, idCustomer: 1, idPitch: idPitch, idPrice: 1, idTime: idTime) { [weak self] (result) in
            HUD.show()
            guard let this = self else { return }
            switch result {
            case .success:
                this.showAlert(alertText: App.ErrorBooking.bookingthePitch, alertMessage: "\(App.ErrorBooking.statusBooking): \(this.viewModel.resultBooking.status)")
            case .failure(let error):
                self?.showAlert(alertText: App.ErrorBooking.errorBooking, alertMessage: "\(App.ErrorBooking.errorInforBooking): \(error)")
            }
            HUD.dismiss()
        }
        stateDatePickerDefault()
    }
    
    // MARK: - Function
    func configSyncRealm() {
        viewModel.delegate = self
        viewModel.setupObserver()
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
                            locationName: viewModel.pitchTotals[i].type?.owner?.address ?? "",
                            coordinate: CLLocationCoordinate2D(latitude: viewModel.pitchTotals[i].type?.owner?.lat ?? 0.0, longitude: viewModel.pitchTotals[i].type?.owner?.lng ?? 0.0))
            pins.append(pin)
        }
    }
    
    func addAnnotations() {
        mapKit.addAnnotations(pins)
    }
    
    func getData() {
        loadData()
    }
    
    private func loadData() {
        viewModel.getAllData { [weak self] result in
            guard let this = self else { return }
            switch result {
            case .success:
                this.viewModel.setupObserver()
                this.tableView.reloadData()
                this.getDataPin()
            case .failure(let error):
                this.showAlert(alertText: App.ErrorBooking.errorInforBooking, alertMessage: "\(App.ErrorBooking.errorInforBooking) \(error)")
            }
        }
    }
    
    // MARK: - Objc Function
    @objc private func changeScreenMapTapped() {
        leftItem = UIBarButtonItem(image: UIImage(named: "ic_listpitch_listview"), style: .plain, target: self, action: #selector(changeScreenList))
        leftItem.tintColor = #colorLiteral(red: 0.6941176471, green: 0.6666666667, blue: 0.5490196078, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.rightBarButtonItem = nil
        navigationItem.title = "Bản Đồ"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        tableView.isHidden = true
        mapKit.isHidden = false
        currentLocationButton.isHidden = false
    }
    
    @objc private func changeScreenList() {
        currentLocationButton.isHidden = true
        let leftItem = UIBarButtonItem(image: UIImage(named: "ic_listpitch_map"), style: .plain, target: self, action: #selector(changeScreenMapTapped))
        leftItem.tintColor = #colorLiteral(red: 0.6941176471, green: 0.6666666667, blue: 0.5490196078, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
        navigationItem.title = ""
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
    func configTableView() {
        let nib = UINib(nibName: "ListPitchTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "ListPitchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - Func Load Date Picker
    private func loadDatePicker() {
        UIView.animate(withDuration: 0.5, animations: {
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
        return viewModel.pitchFilter.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text is \(searchText)")
        searchBar.searchTextField.textColor = #colorLiteral(red: 0.3882352941, green: 0.4823529412, blue: 0.462745098, alpha: 1)
        if searchText.isEmpty {
            viewModel.pitchFilter = viewModel.pitchTotals
        } else {
            viewModel.pitchFilter = viewModel.pitchFilter.filter { ($0.name.contains(searchText)) }
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
                        this.showAlert(alertText: App.Favorite.errorFavorite, alertMessage: "\(App.Favorite.errorFavorite): \(error)")
                    }
                }
            } else {
                viewModel.addFavorite(index: indexPath.row) { [weak self] result in
                    guard let this = self else { return }
                    switch result {
                    case .success:
                        this.tableView.reloadData()
                    case .failure(let error):
                        this.showAlert(alertText: App.Favorite.errorFavorite, alertMessage: "\(App.Favorite.errorFavorite): \(error)")
                    }
                }
            }
        }
    }
    func bookingButton(cell: ListPitchTableViewCell, id: Int) {
        loadDatePicker()
        idPitch = id
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
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.leftCalloutAccessoryView = UIImageView(image: UIImage(named: "ic_listpitch_pin"))
            view.canShowCallout = true
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let detailVC = DetailViewController()
        guard let annotation = view.annotation else { return }
        guard let name = annotation.title else { return }
        for pitch in viewModel.pitchTotals where pitch.name == name {
            detailVC.viewModel = DetailViewModel(pitch: pitch)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

