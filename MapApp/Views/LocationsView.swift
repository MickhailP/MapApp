//
//  LocationView.swift
//  MapApp
//
//  Created by Миша Перевозчиков on 21.05.2022.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    
    @EnvironmentObject private var locationViewModel:  LocationsViewModel
    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationViewModel.mapRegion)
                .ignoresSafeArea()
            VStack(spacing: 0){
                header
                    .padding()
                
                Spacer()
            }
        }
        
    }
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button(action: locationViewModel.toggleLocationList) {
                Text(locationViewModel.mapLocation.name + ", " + locationViewModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: locationViewModel.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: locationViewModel.showLocationList ? -180 : 0))
                    }
                
            }
            if locationViewModel.showLocationList {
                LocationsList()
            }
            
        }
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 10)
    }
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
