//
//  ContentView.swift
//  WeatherAPI_RealData
//
//  Created by Syed Raza on 6/25/23.
//


import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        HStack {
            ForEach(viewModel.weather) { weatherResponse in
                HStack {
                    Text("Lat: \(weatherResponse.coord.lat)")
                        .frame(width: 60, height: 30)
                        .font(.headline)
                    Text("Lon: \(weatherResponse.coord.lon)")
                        .frame(width: 60, height: 30)
                        .font(.headline)
                }
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

