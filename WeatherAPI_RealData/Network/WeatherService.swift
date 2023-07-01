//
//  WeatherService.swift
//  WeatherAPI_RealData
//
//  Created by Syed Raza on 6/25/23.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case emptyData
    case serviceUnavailable
    case decodingError
    case noLocationFound
  
    var description: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        case .emptyData:
            return "Invalid URL"
        case .serviceUnavailable:
            return "Service Not Available"
        case .decodingError:
            return "Decoding Error"
        case .noLocationFound:
            return "No Location Found"
        }
    }
}
struct GeoResponse: Codable {
    let location: [Location]
}
class WeatherService {
    
    var location: Location?
    
    struct Constants {
        
        //        static let geoBaseURL = "https://api.openweathermap.org/data/2.5/weather?q=&limit=1&appid=d9b989c37bd0640006ce9d7350173842"
        static let geoBaseURL = " http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid=d9b989c37bd0640006ce9d7350173842"
        
        static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    }
    
    
    
    
    private func fetchLocationInfo(_ search: String) async throws -> Location {
        
        let encodedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let geoURLString = "\(Constants.geoBaseURL)?q=\(encodedSearch)&limit=1&appid=\(AppInformation.apiKey)"
        
        guard let geoURL = URL(string: geoURLString) else {
            throw APIError.invalidUrl
        }
        
        let (data, response ) = try await URLSession.shared.data(from: geoURL)
        
        guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
            throw APIError.noLocationFound
        }
        return  try JSONDecoder().decode(Location.self, from: data)
    }
    
    
    func fetchWeatherUsingAsyncAwait(lat: Double, lon: Double) async throws -> WeatherResponse {
        guard let weatherURL = URL(string: "\(Constants.baseURL)?lat=\(lat)&lon=\(lon)&appid=\(AppInformation.apiKey)") else {
            throw APIError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: weatherURL)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
    

   
    
