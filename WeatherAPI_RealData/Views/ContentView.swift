//
//  ContentView.swift
//  WeatherAPI_RealData
//
//  Created by Syed Raza on 6/25/23.
//


import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @ObservedObject private var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.orange, .yellow, .cyan, .cyan]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        TextField("Search city", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                            .disableAutocorrection(true)
                        
                        Button(action: {
                            weatherViewModel.useAsyncAwait()
                            searchText = ""
                        }) {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                                .padding(.trailing)
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.white)
                            .opacity(0.7)
                            .frame(maxWidth: 360, maxHeight: 140)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                        
                        VStack {
                            HStack {
                                Text("City: \(weatherViewModel.weather.name)")
                                    .font(.system(size: 28))
                                
                                Text("Temp: \(convertKelvinToFahrenheit(weatherViewModel.weather.main.temp))°")
                                    .font(.system(size: 22))
                            }
                            
                            HStack {
                                Text("High: \(convertKelvinToFahrenheit(weatherViewModel.weather.main.temp_max))°")
                                    .font(.system(size: 20))
                                
                                Text("Low: \(convertKelvinToFahrenheit(weatherViewModel.weather.main.temp_min))°")
                                    .font(.system(size: 20))
                            }
                        }
                        .frame(maxWidth: 340, maxHeight: 120)
                        .padding()
                    }
                    .frame(maxWidth: 360)
                }
            }
            .navigationTitle("Weather")
        }
        .onAppear {
            Task {
                await weatherViewModel.useAsyncAwait()
            }
        }
    }
    
    private func convertKelvinToFahrenheit(_ kelvin: Double) -> Int {
        Int((kelvin - 273.15) * 9/5 + 32)
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

