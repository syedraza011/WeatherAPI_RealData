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
            //-------
            VStack {
                TextField("Enter city name", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .disableAutocorrection(true)
                
                Button(action: {
                    ViewModel.getWeather(searchText)
                    searchText = ""
                }) {
                    Text("Search")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                //-----
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [.orange, .yellow, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea() // background of the app
                    
                    
                    
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.cyan, .cyan, .yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .opacity(0.5)
                            .border(.black, width: 0.5)
                            .cornerRadius(25)
                            .frame(maxWidth: 360, maxHeight: 140, alignment: .topLeading)
                        
                        // for the weather :)
                        VStack {
                            
                            HStack { // city, temp
                                Text("City: \(ViewModel.locationWeather.response.name)")
                                    .font(.system(size: 28))
                                Text("Temp: \(((ViewModel.locationWeather.response.main.temp-273.15) * (9/5) + 32))°")
                                    .font(.system(size: 22))
                            }
                            
                            HStack { // highs, lows
                                Text("High: \(((ViewModel.locationWeather.response.main.temp_max-273.15) * (9/5) + 32))°")
                                    .font(.system(size: 20))
                                Text("Low: \(((ViewModel.locationWeather.response.main.temp_min-273.15) * (9/5) + 32))°")
                                    .font(.system(size: 20))
                            }
                            
                        }
                        .frame(maxWidth: 340, maxHeight: 120, alignment: .topLeading)
                        .background( Color.blue )
                        
                    } // zstack 21 closure
                    .frame(maxWidth: 360, maxHeight: .infinity, alignment: .topLeading)
                    
                } // zstack 17 closure
                .navigationTitle(Text("Weather"))
            } // nav 16 closure
            .onAppear {
                ViewModel.getWeather(searchText)
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

