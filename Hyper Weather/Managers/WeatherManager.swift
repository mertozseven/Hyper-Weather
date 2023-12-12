//
//  WeatherManager.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 13.12.2023.
//

import CoreLocation
import WeatherKit
import Foundation

final class WeatherManager {
    
    static let shared = WeatherManager()
    
    let service = WeatherService.shared
    
    public private(
        set
    ) var currentWeather: CurrentWeather?
    public private(
        set
    ) var hourlyWeather: [HourWeather] = []
    public private(
        set
    ) var dailytWeather: [DayWeather] = []
    
    private init() {
        
    }
    
    public func getWeather(
        for location: CLLocation,
        completion: @escaping () -> Void
    ) {
        Task {
            do {
                let result = try await service.weather(
                    for: location
                )
                print(
                    "Current Weather is \(result.currentWeather)"
                )
                print(
                    "Daily Forecast: \(result.dailyForecast)"
                )
                print(
                    "Hourly Forecast: \(result.hourlyForecast)"
                )
                
                self.currentWeather = result.currentWeather
                self.dailytWeather = result.dailyForecast.forecast
                self.hourlyWeather = result.hourlyForecast.forecast
                completion()
            } catch {
                print(
                    "\n\nError:" + String(
                        describing: error
                    )
                )
            }
        }
    }
}
