//
//  LocationsList.swift
//  MapApp
//
//  Created by Миша Перевозчиков on 21.05.2022.
//

import SwiftUI

struct LocationsList: View {
    
    @EnvironmentObject private var locationViewModel:  LocationsViewModel

    var body: some View {
        List {
            ForEach(locationViewModel.locations) { location in
                Button{
                    locationViewModel.showNextLocation(location: location)
                } label: {
                    listRowView(location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
                
            }
        }
        .listStyle(.plain)
    }
}

extension LocationsList {
    
    private func listRowView(_ location: Location) -> some View {
        HStack{
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
            }
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LocationsList_Previews: PreviewProvider {
    static var previews: some View {
        LocationsList()
            .environmentObject(LocationsViewModel())
    }
}
