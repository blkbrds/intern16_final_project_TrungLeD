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
    var viewModel: ListPitchViewModel = ListPitchViewModel()
    var pitch: [Pitch]?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configureUI()
        mapViewState()
        configSyncRealm()
        getData()
        configMapKit()
        addAnnotationPitch()
        addAnnotationUserLocation()
        configRouting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Helper Functions
    private func configMapKit() {
          guard let latitude = LocationManager.shared.currentLatitude, let longtitude = LocationManager.shared.currentLongitude else { return }
          let location = CLLocation(latitude: (CLLocationDegrees(viewModel.lat) + latitude) / 2, longitude: (CLLocationDegrees(viewModel.long) + longtitude) / 2)
          let span = MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.5), longitudeDelta: CLLocationDegrees(0.5))
          let region = MKCoordinateRegion(center: location.coordinate, span: span)
          mapKit.setRegion(region, animated: true)
          mapKit.delegate = self
    }
    
    private func addAnnotationPitch() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(viewModel.lat), longitude: CLLocationDegrees(viewModel.long))
        annotation.title = viewModel.namePitch
        annotation.subtitle = viewModel.addressPitch
        mapKit.addAnnotation(annotation)
    }
    
    private func addAnnotationUserLocation() {
        let annotation = MKPointAnnotation()
        guard let latitude = LocationManager.shared.currentLatitude, let longtitude = LocationManager.shared.currentLongitude else { return }
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
        annotation.title = "user's location"
        mapKit.addAnnotation(annotation)
    }
    
    private func routing(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
           let request = MKDirections.Request()
           request.source = MKMapItem(placemark: MKPlacemark(coordinate: source, addressDictionary: nil))
           request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination, addressDictionary: nil))
           request.requestsAlternateRoutes = false
           let directions = MKDirections(request: request)
           directions.calculate { (response, _) in
               guard let response = response else { return }
               guard let route: MKRoute = response.routes.first else { return }
               self.mapKit.addOverlay(route.polyline)
               self.mapKit.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
           }
       }
    
    private func configRouting() {
        let source = CLLocationCoordinate2D(latitude: CLLocationDegrees(viewModel.lat), longitude: CLLocationDegrees(viewModel.long))
        guard let latitude = LocationManager.shared.currentLatitude, let longtitude = LocationManager.shared.currentLongitude else { return }
              let destination = CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
              routing(source: source, destination: destination)
        routing(source: source, destination: destination)
    }
    
    // MARK: - Objc Function
    var leftItem = UIBarButtonItem()
    @objc private func mapViewState() {
        leftItem = UIBarButtonItem(image: UIImage(named: "ic_listpitch_listview"), style: .plain, target: self, action: #selector(listView))
        leftItem.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
        tableView.isHidden = true
        mapKit.isHidden = false
    }
    @objc private func listView() {
        let leftItem = UIBarButtonItem(image: UIImage(named: "ic_listpitch_map"), style: .plain, target: self, action: #selector(mapViewState))
        leftItem.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        navigationItem.leftBarButtonItem = leftItem
        tableView.isHidden = false
        mapKit.isHidden = true
    }
    
    private let regionRadius: CLLocationDistance = 10000 // 10 km
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

extension ListPitchViewController: ListPitchTableViewCellDelegate {
    func bookingButton(view: ListPitchTableViewCell) {
        
    }
    
    func handleFavoriteTableView(cell: ListPitchTableViewCell, id: String, isFavorite: Bool) {
        if isFavorite {
            viewModel.unfavorite(id: id)
        } else {
            viewModel.addFavorite(id: cell.viewModel?.id ?? "", namePitch: cell.viewModel?.name ?? "", addressPitch: cell.viewModel?.addressOwner ?? "", timeUse: cell.viewModel?.timeUser ?? "")
        }
        tableView.reloadData()
    }
}
extension ListPitchViewController: ListPitchViewModelDelegate {
    func syncFavorite(viewModel: ListPitchViewModel, needperformAction action: ListPitchViewModel.Action) {
        tableView.reloadData()
    }
}

// Extension: - MapKit
extension ListPitchViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .green
        renderer.lineWidth = 3.0
            return renderer
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        }
        if annotation.title == viewModel.namePitch {
            annotationView?.image = UIImage(named: "img_detail_pitch")
        } else {
            annotationView?.image = #imageLiteral(resourceName: "ic_listpitch_location")
        }
        annotationView?.canShowCallout = true
        return annotationView
        }
}
