//
//  Location.swift
//  MapApp
//
//  Created by Миша Перевозчиков on 21.05.2022.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    var id: String {
        name + cityName
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.id == rhs.id
    }

    
   static let example = Location(name: "Apple", cityName: "Cupertiono", coordinates: CLLocationCoordinate2D(latitude: 37.3318, longitude: -122.0312), description: "Apple headquarter", imageNames: [], link: "https://www.apple.com")
}
