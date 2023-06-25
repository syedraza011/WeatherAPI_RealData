//
//  WeatherResponse.swift
//  WeatherAPI_RealData
//
//  Created by Syed Raza on 6/25/23.
//

import Foundation

struct Location: Codable {
    let name: String
    let country: String
    let state: String
    let lat: Double
    let lon: Double
}
struct WeatherResponse: Codable {
    let name: String
    let coord: Coord
    let weather: [Weather]
    let timezone: Int
}
struct Coord: Codable {
    let lat: Double
    let lon: Double
    
}
struct Weather: Codable {
    let icon: String
}
struct Main : Codable {
    let temp: Double
    let feels_like : Double
    let temp_min : Double
    let temp_max : Double
}
