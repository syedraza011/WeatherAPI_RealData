//
//  WeatherResponse.swift
//  WeatherAPI_RealData
//
//  Created by Syed Raza on 6/25/23.
//

import Foundation
struct WeatherResponse: Decodable, Identifiable {
    var id = UUID()
    let name: String
    let coord: Coord
    let weather: [Weather]
    let timezone: Int
}

struct Coord: Decodable {
    let lat: Double
    let lon: Double
    
    static let mockData = [
        Coord(lat: 10.50, lon: 44.34),
        Coord(lat: 10.50, lon: 44.34)
    ]
}

struct Weather: Decodable {
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct Location: Codable {
    let name: String
    let country: String
    let state: String
    let lat: Double
    let lon: Double
}

//struct WeatherResponse: Decodable , Identifiable{
//
//    var id = UUID()
//    let name: String
//    let coord: Coord
//    let weather: [Weather]
//    let timezone: Int
//}
//struct Location: Codable {
//    let name: String
//    let country: String
//    let state: String
//    let lat: Double
//    let lon: Double
//}

//struct Coord: Codable {
//    let lat: Double
//    let lon: Double
//    
//    static let mockData=[
//        Coord( lat: 10.50, lon: 44.34 ),
//        Coord( lat: 10.50, lon: 44.34 )
//        ]
//}
//struct Weather: Decodable {
//    let icon: String
//}
//struct Main : Codable {
//    let temp: Double
//    let feels_like : Double
//    let temp_min : Double
//    let temp_max : Double
//}
//struct Coord: Decodable{
//
//
//    let lat: Double
//    let lon: Double
//
//    static let mockData = [
//        Coord(lat: 10.50, lon: 44.34),
//        Coord(lat:10.50, lon: 44.34)
//    ]
//}

