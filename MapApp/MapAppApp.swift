//
//  MapAppApp.swift
//  MapApp
//
//  Created by Миша Перевозчиков on 21.05.2022.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var locationViewModel = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                
                LocationsView()
            }
            .environmentObject(locationViewModel)
        }
    }
}
