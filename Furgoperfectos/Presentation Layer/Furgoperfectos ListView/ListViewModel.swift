//
//  ListViewModel.swift
//  Furgoperfectos
//
//  Created by Josep Escobar on 12/03/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Combine
import Foundation
import CoreLocation

final class FurgoperfectoListViewModel: Identifiable {
    let id: String
    var name: String
    var descriptionItem: String
    var distance: String
    var imageURL: URL
    
    init(id: String, name: String?, description: String, distance: String, imageURL: URL) {
        self.id = id
        self.name = name ?? "No name"
        self.descriptionItem = description
        self.distance = distance
        self.imageURL = imageURL
    }
}

class ListViewModel: NSObject, ObservableObject {
    let didChange = PassthroughSubject<ListViewModel, Never>()
    var repository: FurgoperfectosRepository?
    var locationManager: CLLocationManager
    var userCoordinates: CLLocation?
    let defaultImg = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fthenounproject.com%2Fterm%2Fno-image%2F340719%2F&psig=AOvVaw2oryJuvN5BcJ71abF_2Ha-&ust=1595787343322000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCLCntaCB6eoCFQAAAAAdAAAAABAE"
    
    var arrayFurgoperfectos: [FurgoperfectoListViewModel] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        self.repository = FurgoperfectosRepository(delegate: self)
        self.repository?.fetchData()
    }
}

extension ListViewModel: FurgoperfectosRepositoring {
    #warning("TODO: @josepescobar, 25/07/2020, Remove force unwrap on URL")
    #warning("TODO: @josepescobar, 25/07/2020, check id manage")
    #warning("TODO: @josepescobar, 25/07/2020, do mapping in other layer")
    func provideFurgoperfectos(_ furgoperfectosArray: [FurgoperfectoDataModel]) {
        var furgoperfectosDomainModelArray = furgoperfectosArray
            .map {
                FurgoperfectoModel(dataModel: $0)}
            .compactMap { $0 }
        
        if let coordinates = userCoordinates {
            furgoperfectosDomainModelArray = furgoperfectosDomainModelArray.sorted(by: coordinates)
        }
        
        arrayFurgoperfectos = furgoperfectosDomainModelArray.map {
            FurgoperfectoListViewModel(id: $0.id,
                                       name: $0.name,
                                       description: "",
                                       distance: calculateDistance(userCoordinates, location: $0.coordinates.location),
                                       imageURL: URL(string: $0.imagen ?? defaultImg) ?? URL(string: defaultImg)!)
        }
    }
    
    private func calculateDistance(_ userlocation: CLLocation?, location: CLLocation) -> String {
        guard let userlocation = userlocation else { return "NaN"}
        let distanceInMeters = Int(userlocation.distance(from: location))
        if distanceInMeters < 1000 {
            return "A \(distanceInMeters)m de tí."
        }
        return "A \(distanceInMeters / 1000)Km de tí."
    }
    
    func onError(_ error: Error) {
    }
}

extension ListViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        userCoordinates = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
    }
}
