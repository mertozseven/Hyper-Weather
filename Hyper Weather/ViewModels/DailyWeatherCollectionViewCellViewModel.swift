//
//  DailyWeatherCollectionViewCellViewModel.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 14.12.2023.
//

import Foundation
import WeatherKit

struct DailyWeatherCollectionViewCellViewModel {
    private let model: DayWeather
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    init(
        model: DayWeather
    ) {
        self.model = model
    }
    public var iconName: String {
        return model.symbolName
    }
    public var highTemperature: String {
        return model.highTemperature.description
    }
    public var lowTemperature: String {
        return model.lowTemperature.description
    }
    public var weekday: String {
        let weekday = Calendar.current.component(
            .weekday,
            from: model.date
        )
        return "\(string(from: weekday))"
    }
    private func string(
        from weekday: Int
    ) -> String {
        switch (
            weekday
        ) {
        case 1:
            return "Monday"
        case 2:
            return "Tuesday"
        case 3:
            return "Wednesday"
        case 4:
            return "Thursday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        case 7:
            return "Sunday"
        default:
            return ""
        }
    }
}
