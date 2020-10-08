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
    
    // MARK: - Properties
    var pins: [MyPin] = []
    var inputDate: [Date] = []
    private var viewModel: ListPitchViewModel = ListPitchViewModel()
    var pitch: [Pitch]?
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = .black
        nav?.tintColor = .white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        tableView.reloadData()
        viewModel.fetchRealmData()
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
        let eiffelTowerLocation = CLLocation(latitude: 16.05228, longitude: 108.1919426)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: eiffelTowerLocation.coordinate, span: span)
        mapKit.region = region
    }
    
    func getDataPin() {
        for i in 0..<viewModel.pitchTotals.count {
            let pin = MyPin(title: viewModel.pitchTotals[i].name,
                            locationName: viewModel.pitchTotals[i].address,
                            coordinate: CLLocationCoordinate2D(latitude: viewModel.pitchTotals[i].type.owner.lat, longitude: viewModel.pitchTotals[i].type.owner.lng))
            pins.append(pin)
        }
        print(pins)
    }
    
    func addAnnotations() {
        mapKit.addAnnotations(pins)
    }
    
    func getData() {
        viewModel.fetchRealmData()
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
                print(error)
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
        searchBar.delegate = self
        tableView.isHidden = false
        mapKit.isHidden = true
    }
    
    // MARK: - Function
    private func configureUI() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func configTableView() {
        let nib = UINib(nibName: "ListPitchTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "ListPitchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadDatePicker() {
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
        detailVC.hidesBottomBarWhenPushed = true
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
    func bookingButton(view: ListPitchTableViewCell) {
        
    }
    
    func handleFavoriteTableView(cell: ListPitchTableViewCell, id: Int, isFavorite: Bool) {
        if isFavorite {
            viewModel.unfavorite(id: id)
        } else {
            viewModel.addFavorite(id: cell.viewModel?.id ?? 0,
                                  namePitch: cell.viewModel?.name ?? "",
                                  addressPitch: cell.viewModel?.addressOwner ?? "",
                                  timeUse: cell.viewModel?.timeUser ?? "",
                                  phone: cell.viewModel?.phoneOwner ?? "",
                                  pitchType: cell.viewModel?.pitchType ?? "")
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
