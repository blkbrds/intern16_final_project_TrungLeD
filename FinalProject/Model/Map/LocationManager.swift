//
//  LocationManager.swift
//  FinalProject
//
//  Created by Abcd on 10/7/20.
//  Copyright © 2020 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject {

    static let shared = LocationManager()
    lazy var manager = CLLocationManager()
    private(set) var currentLocation: CLLocation?
    // Call back after get current location.
    var getLocationCompletion: (() -> Void)?

    var currentLatitude: CLLocationDegrees? {
        return currentLocation?.coordinate.latitude
    }

    var currentLongitude: CLLocationDegrees? {
        return currentLocation?.coordinate.longitude
    }

    var allowAccessLocation: Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }

    // Config Location
    func enableLocationServices() {
        CLLocationManager.locationServicesEnabled()
    }

    // Standard location service
    func startStandardLocationService() {
        manager.startUpdatingLocation()
    }

    func stopStandardLocationService() {
        manager.stopUpdatingLocation()
    }

    func startSignificantChangeLocationService() {
        manager.startMonitoringSignificantLocationChanges()
    }

    func stopSignificantChangeLocationService() {
        manager.startMonitoringSignificantLocationChanges()
    }

    func configLocationService() {
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.distanceFilter = 500
        manager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            enableLocationServices()
            startStandardLocationService()
        case .denied, .restricted: break
        @unknown default:
            break
        }
    }

    func configLocationServiceNotShowPermission() {
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.distanceFilter = 500
        manager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            enableLocationServices()
            startStandardLocationService()
        case .denied, .restricted, .notDetermined: break
        @unknown default:
            break
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            stopStandardLocationService()
        case .authorizedWhenInUse, .authorizedAlways:
            enableLocationServices()
            startStandardLocationService()
        case .notDetermined: break
        @unknown default:
            fatalError()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        getLocationCompletion?()
        getLocationCompletion = nil
        stopStandardLocationService()
    }
}

