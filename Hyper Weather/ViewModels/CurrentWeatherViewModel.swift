//
//  CurrentWeatherViewModel.swift
//  Hyper Weather
//
//  Created by Mert Ozseven on 14.12.2023.
//

import Foundation

enum WeatherViewModel {
    case current(
        viewModel: CurrentWeatherCollectionViewCellViewModel
    )
    case hourly(
        viewModel: [HourlyWeatherCollectionViewCellViewModel]
    )
    case daily(
        viewModel: [DailyWeatherCollectionViewCellViewModel]
    )
}
