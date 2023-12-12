//
//  HourlyWeatherCollectionViewCellViewModel.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 14.12.2023.
//

import Foundation
import WeatherKit

struct HourlyWeatherCollectionViewCellViewModel {
    
    private let model: HourWeather
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    init(
        model: HourWeather
    ) {
        self.model = model
    }
    public var iconName: String {
        return model.symbolName
    }
    public var temperature: String {
        return model.temperature.description
    }
    public var hour: String {
        let hour = Calendar.current.component(
            .hour,
            from: model.date
        )
        let minute = Calendar.current.component(
            .minute,
            from: model.date
        )
        return "\(hour):\(minute)0"
    }
}
