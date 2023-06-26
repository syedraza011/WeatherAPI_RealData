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
    @Published var weather = [WeatherResponse]()
    let service = WeatherService()

    @MainActor
    func useAsyncAwait() {
        Task {
            do {
                self.weather = try await service.fetchWeatherUsingAsyncAwait()

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

//class WeatherViewModel: ObservableObject {
//    @Published var weather = [WeatherResponse]()
//    let service = WeatherService()
//
//    @MainActor
//    func useAsyncAwait() {
//        Task {
//            do {
//                self.weather = try await service.fetchWeatherUsingAsyncAwait()
//
//            } catch {
//                if let error = error as? APIError {
//                    print(error.description)
//                } else {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
//}
//
//class WeatherViewModel: ObservableObject {
//    @Published var weather = [WeatherResponse]()
//    let service = WeatherService()
//
//    class WeatherViewModel: ObservableObject {
//        let service = WeatherService()
//
//        @MainActor func useAsyncAwait() {
//            Task {
//                do {
//                    self.weather = try await service.fetchUsingAsyncAwait()
//
//                } catch {
//                    if let error = error as? APIError {
//                        print(error.description)
//                    } else {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//        }
//    }
//
//}




