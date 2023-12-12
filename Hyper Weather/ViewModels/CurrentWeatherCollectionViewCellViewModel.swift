//
//  CurrentWeatherCollectionViewCellViewModel.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 14.12.2023.
//

import WeatherKit
import Foundation

struct CurrentWeatherCollectionViewCellViewModel {
    
    private let model: CurrentWeather
    init(
        model: CurrentWeather
    ) {
        self.model = model
    }
    
    public var condition: String {
        return model.condition.description
    }
    
    public var temperature: String {
        return model.temperature.description
    }
    
    public var iconName: String {
        return model.symbolName
    }
    
    
    
}
