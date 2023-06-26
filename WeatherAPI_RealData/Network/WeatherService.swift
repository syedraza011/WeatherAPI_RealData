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
        static let geoBaseURL = "https://api.openweathermap.org/data/2.5/weather?q=&limit=1&appid=d9b989c37bd0640006ce9d7350173842"
        static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    }
    
    
    
    
    //    private func fetchLocationInfo(_ search: String) async throws -> Location {
    //
    //        let encodedSearch = search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    //
    //        let geoURLString = "\(Constants.geoBaseURL)?q=\(encodedSearch)&limit=1&appid=\(AppInformation.apiKey)"
    //
    //        guard let geoURL = URL(string: geoURLString) else {
    //            throw APIError.invalidUrl
    //        }
    //
    //        let (data, _ ) = try await URLSession.shared.data(from: geoURL)
    //
    //        do {
    //            let decodedData = try JSONDecoder().decode(GeoResponse.self, from: data)
    //            guard let location = decodedData.location.first else {
    //                throw APIError.noLocationFound
    //            }
    //            return location
    //        } catch {
    //            throw APIError.invalidResponse
    //        }
    //    }
    //
    //    func fetchWeatherUsingAsyncAwait(lat: Double, lon: Double) async throws -> WeatherResponse {
    //        location = nil
    //
    //        let weatherURLString = "\(Constants.baseURL)?lat=\(lat)&lon=\(lon)&appid=\(AppInformation.apiKey)"
    //
    //        do {
    //            let location = try await fetchLocationInfo(lat : lat , lon:lon)
    //            let response = try await fetchWeatherUsingAsyncAwait(lat: location.lat, lon: location.lon)
    //
    //            if self.location == nil {
    //                throw APIError.emptyData
    //            }
    //
    //            return response
    //        } catch {
    //            throw error
    //        }
    //    }
    
    
   //
    func fetchWeatherUsingAsyncAwait() async throws -> [WeatherResponse] {
       
        
        do {
            guard let url = URL(string: Constants.geoBaseURL) else {
                throw APIError.invalidUrl
            }
            
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw APIError.invalidResponse
            }
            
            do {
                return try JSONDecoder().decode([WeatherResponse].self, from: data)
            } catch {
                throw APIError.decodingError
            }
        }
        
    }
    
}
