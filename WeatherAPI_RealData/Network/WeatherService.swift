//
//  WeatherService.swift
//  WeatherAPI_RealData
//
//  Created by Syed Raza on 6/25/23.
//

import Foundation
import Combine

// to throw errors within service
enum APIError: Error {
    case invalidURL(_ urlString: String)
    case invalidResponse(_ responseString: String)
    var description: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}

class WeatherService {
    
  
    struct APIconstants {
        static let geoBaseURL = "https://api.openweathermap.org/geo/1.0/direct"
        static let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather"
        static let APIKey = "efc23031ee630165e1c5a632b7faaccb"
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        guard let url = URL(string: "\(APIconstants.weatherBaseURL)?lat=\(lat)&lon=\(lon)&appid=\(APIconstants.APIKey)") else { throw APIError.invalidURL("Invalid URL") }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
            throw APIError.invalidResponse("Invalid Response")
        }
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    } 
    
    
  
    func fetchGeoLocation(_search: String) async throws -> [Location] {
        
     
        let encodedSearch = _search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        guard let url = URL(string: "\(APIconstants.geoBaseURL)?q=\(encodedSearch)&limit=1&appid=\(APIconstants.APIKey)") else { throw APIError.invalidURL("Invalid URL") }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
            throw APIError.invalidResponse("Invalid Response")
        }
        return try JSONDecoder().decode([Location].self, from: data)
    }
    
}



   
    
