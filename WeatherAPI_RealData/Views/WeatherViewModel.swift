//
//  WeatherViewModel.swift
//  WeatherAPI_RealData
//
//  Created by Syed Raza on 6/25/23.
//
import Foundation
import Combine
// for error throwing in here
enum NetworkError: Error {
    case invalidResponse
    var description: String {
        switch self {
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}

// struct that holds that location's weather
struct WeatherData: Identifiable {
    let id = UUID()
    var response: WeatherResponse
    init(response: WeatherResponse) {
        self.response = response
    }
}

class WeatherViewModel: ObservableObject {
    
    let service = WeatherService()
   
    @Published var locationWeather = WeatherData(
        response: WeatherResponse(name: "Alameda", main: Main(temp: 287.54, feels_like: 287.23, temp_min: 284.55, temp_max: 295.22), coord: Coord(lat: -122.5, lon: 22.6))
    )
  
    @MainActor func getWeather(_ city: String) {
        Task {
            do {
                let loc: [Location] = try await service.fetchGeoLocation(_search: city)
              
                self.locationWeather = WeatherData(response: try await service.fetchWeather(lat: loc[0].lat, lon: loc[0].lon))
            } catch {
                if let error = error as? NetworkError {
                   print(error.description)
                } else {
                    print(error.localizedDescription)
                }
            }
        }
    } // end mainactor func
}





