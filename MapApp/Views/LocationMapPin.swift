//
//  LocationMapPin.swift
//  MapApp
//
//  Created by Миша Перевозчиков on 24.05.2022.
//

import SwiftUI

struct LocationMapPin: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.accentColor)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFill()
                .foregroundColor(.accentColor)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

struct LocationMapPin_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapPin()
    }
}
