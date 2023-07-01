//
//  ContentView.swift
//  WeatherAPI_RealData
//
//  Created by Syed Raza on 6/25/23.
//


import SwiftUI
struct ContentView: View {

    @State var searchText = "" // for the search bar
    @StateObject var ViewModel = WeatherViewModel() // for the weather view

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.orange, .yellow, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea() // background of the app

                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.cyan, .cyan, .yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .opacity(0.5)
                        .border(.black, width: 0.5)
                        .cornerRadius(25)
                        .frame(maxWidth: 360, maxHeight: 140, alignment: .topLeading)


                    VStack {

                        HStack{ // city, temp
                            Text("\(ViewModel.locationWeather.response.name)")
                                .font(.system(size: 28))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(formattedTemperature((ViewModel.locationWeather.response.main.temp-273.15) * (9/5) + 32))°")
                                .font(.system(size: 22))
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }

                        VStack{
                            HStack { // highs, lows
                                Text("H: \(formattedTemperature((ViewModel.locationWeather.response.main.temp_max-273.15) * (9/5) + 32))°")
                                    .font(.system(size: 20))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            HStack{
                                Text("L: \(formattedTemperature((ViewModel.locationWeather.response.main.temp_min-273.15) * (9/5) + 32))°")
                                    .font(.system(size: 20))
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }

                        }
                    }
                    .frame(maxWidth: 340, maxHeight: 120, alignment: .topLeading)
                    .background(Color.blue)

                }
                .frame(maxWidth: 360, maxHeight: .infinity, alignment: .topLeading)

            }
            .navigationTitle(Text("Weather"))
            .searchable(text: $searchText, prompt: "Search for a city/state in USA")
            .onSubmit(of: .search) {
                ViewModel.getWeather(searchText)
            }
        }
    }

    private func formattedTemperature(_ temperature: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: temperature)) ?? ""
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

