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
        }
    }
}

class WeatherService {
    struct Constants {
        static let baseURL = "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_KEY}"
    }

    func fetchWeatherUsingAsyncAwait() async throws -> [WeatherResponse] {
        guard let url = URL(string: Constants.baseURL) else {
            throw APIError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode([WeatherResponse].self, from: data)
        } catch {
            throw APIError.decodingError
        }
    }

}
