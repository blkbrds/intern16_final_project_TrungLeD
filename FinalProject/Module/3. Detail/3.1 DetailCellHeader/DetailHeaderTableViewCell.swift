//
//  DetailHeaderTableViewCell.swift
//  FinalProject
//
//  Created by Trung Le D. on 10/1/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MapKit

class DetailHeaderTableViewCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet var bookingBtn: UIButton!
    @IBOutlet var mapView: MKMapView!
    
    // MARK: Properties
    
    var viewModel: DetailHeaderCellViewModel? {
        didSet {
            updateView()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateView() {
        bookingBtn.layer.cornerRadius = 15
        addAnnotation()
        mapView.delegate = self
    }
    
    private func addAnnotation() {
        mapView.showsUserLocation = true
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: viewModel?.lat ?? -1, longitude: viewModel?.long ?? -1)
        annotation.title = viewModel?.address
        mapView.addAnnotation(annotation)
        mapView.setCenter(annotation.coordinate, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func bookingtapped(_ sender: Any) {
        
    }
}

// MARK: - Extension
extension DetailHeaderTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        pin.animatesDrop = true
        pin.tintColor = .green
        return pin
    }
}
