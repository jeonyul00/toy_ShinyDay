//
//  Forecase.swift
//  ShinyDay
//
//  Created by 전율 on 11/4/24.
//

import Foundation
import UIKit

struct Forecast:Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ListItem]
    
    struct ListItem:Codable {
        let dt: Int
        let main: Main
        let weather: [Weather]
    }

    struct Main: Codable {
        let temp: Double
    }

    struct Weather: Codable {
        let description: String
        let icon: String
    }
}

struct ForecastData {
    let date: Date
    let icon: String
    let weather: String
    let temperature: Double
}

