//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by Миша Перевозчиков on 21.05.2022.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject{
    
    //All loaded locations
    @Published private(set) var locations: [Location]
    
    //Current location on map
    @Published var mapLocation: Location {
        //will automatically update coordinate every time when we change a location
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    //Current location on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    //Show list if Locations
    @Published var showLocationList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        
        let locationExample = Location.example
        self.mapLocation = locations.first ?? locationExample
        self.updateMapRegion(location: locations.first ?? locationExample)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)
        }
    }
    
     func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
}

