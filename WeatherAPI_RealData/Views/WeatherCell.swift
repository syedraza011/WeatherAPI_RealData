//
//  WeatherCell.swift
//  WeatherAPI_RealData
//
//  Created by Syed Raza on 6/26/23.
//

import SwiftUI

struct Weather {
    let lat: Double
    let lon: Double
}

struct WeatherCell: View {
    let weather: Weather

    var body: some View {
        VStack {
            Text("Single Post")
                .font(.title)
                .foregroundColor(.primary)
                .padding()

            VStack(alignment: .leading, spacing: 8) {
                Text("Lat: \(weather.lat)")
                    .frame(width: 60, height: 30)
                    .font(.headline)
                Text("Lon: \(weather.lon)")
                    .frame(width: 60, height: 30)
                    .font(.headline)
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding()

            Spacer()
        }
    }
}

struct WeatherCell_Previews: PreviewProvider {
    static var previews: some View {
        let mockWeather = Weather(lat: 50.89, lon: 45.50)
        return WeatherCell(weather: mockWeather)
    }
}




