//
//  WeatherViewModel.swift
//  WeatherAPI_RealData
//
//  Created by Syed Raza on 6/25/23.
//
import SwiftUI
import Foundation
import Combine


class WeatherViewModel: ObservableObject {
    let service = WeatherService()
    
    let weather = Weather(icon: "sun.max.fill")
    
    let weatherResponse = WeatherResponse(
        name: "Almeda",
        coord: Coord(lat: -122.5, lon: 22.6),
        weather: [self.weather],
        main: Main(temp: 287.54, feels_like: 294.33, temp_min: 275.97, temp_max: 295.22),
        timezone: 0
    )
    
    @Published var currentWeather: WeatherResponse
    
    init() {
        currentWeather = weatherResponse
    }
    
    @MainActor func useAsyncAwait() {
        let city = "Almeda" // Replace with the desired city
        
        Task {
            do {
                let loc: Location = try await service.fetchWeatherUsingAsyncAwait(_ search: city)
                self.currentWeather = try await service.fetchWeatherUsingAsyncAwait(lat: loc.lat, lon: loc.lon)
            } catch {
                if let error = error as? APIError {
                    print(error.description)
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    }
}




