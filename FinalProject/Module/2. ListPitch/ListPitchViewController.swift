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
    
    // MARK: - Properties
    var inputDate: [Date] = []
    private var viewModel: ListPitchViewModel = ListPitchViewModel()
    var pitch: [Pitch]?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configureUI()
        mapView()
        configSyncRealm()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        viewModel.fetchRealmData()
    }
    
    // MARK: - Function
    func configSyncRealm() {
        viewModel.delegate = self
        viewModel.setupObserve()
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
            case .failure(let error):
                this.showAlert(alertText: "Error", alertMessage: "error loadData \(error)")
            }
        }
    }
    
    // MARK: - Helper Functions
    private func configMapKit() {
        let initLocation = CLLocation(latitude: 16.060440, longitude: 108.236290)
        zoomOnMap(location: initLocation)
    }
    
    // MARK: - Objc Function
    var leftItem = UIBarButtonItem()
    @objc private func mapView() {
        leftItem = UIBarButtonItem(image: UIImage(named: "ic_listpitch_listview"), style: .plain, target: self, action: #selector(listView))
        leftItem.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
        tableView.isHidden = true
        mapKit.isHidden = false
    }
    @objc private func listView() {
        let leftItem = UIBarButtonItem(image: UIImage(named: "ic_listpitch_map"), style: .plain, target: self, action: #selector(mapView))
        leftItem.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
        tableView.isHidden = false
        mapKit.isHidden = true
    }
    
    private let regionRadius: CLLocationDistance = 10000 // 10 km
    
    // MARK: - Function
    func zoomOnMap(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius * 2, longitudinalMeters: regionRadius * 2 )
        mapKit.setRegion(coordinateRegion, animated: true)
    }
    
    private func configureUI() {
        let searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width - 100, height: 0))
        searchBar.placeholder = "Nhập Tên Sân"
        let rightNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        searchBar.delegate = self
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
