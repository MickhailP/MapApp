//
//  LocationDetailedView.swift
//  MapApp
//
//  Created by Миша Перевозчиков on 24.05.2022.
//

import SwiftUI
import MapKit

struct LocationDetailedView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var locationViewModel: LocationsViewModel
    let location: Location
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                    .shadow(color: .black.opacity(0.5), radius: 20, y: -10)
                
                VStack(alignment: .leading, spacing: 16) {
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                 
            }
        }
        
        .ignoresSafeArea()
        .overlay(backButton, alignment: .topLeading)
        .background(.ultraThickMaterial)
    }
}

struct LocationDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailedView(location: LocationsDataService.locations.first!)
            .environmentObject(LocationsViewModel())
    }
}

extension LocationDetailedView {
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.name)
                .font(.title)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(location.description)
                .font(.subheadline)
            if let url = URL(string: location.link){
                Link("Read more at Wikipedia", destination: url)
                    .font(.headline)
            }
        }
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapPin()
                    .shadow(radius: 10)
            }
        }
            .allowsTightening(false)
            .aspectRatio(1, contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.title)
                .foregroundColor(.primary)
                .padding(10)
                .background(.ultraThickMaterial)
                .clipShape(Circle())
                .shadow(radius: 10)
                .padding()
            
        }

    }
}
