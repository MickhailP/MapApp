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
    
    let maxWidthForIpad: CGFloat = 700
    
    var body: some View {
        ZStack {
            mapLayer
            VStack(spacing: 0){
                header
                    .padding()
                    .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationStackView
                .padding()
            }
        }
        .sheet(item: $locationViewModel.detailedLocation) { location in
            LocationDetailedView(location: location)
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
    
    private var mapLayer: some View {
        Map(coordinateRegion: $locationViewModel.mapRegion,
            annotationItems: locationViewModel.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapPin()
                    .scaleEffect(locationViewModel.mapLocation == location ? 1 : 0.7)
                    .shadow(color: .black.opacity(0.3), radius: 10)
                    .onTapGesture {
                        locationViewModel.showNextLocation(location: location)
                    }
            }
        })
            .ignoresSafeArea()
    }
    
    private var locationStackView: some View {
        ZStack {
            ForEach(locationViewModel.locations) { location in
                if locationViewModel.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}


struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}
