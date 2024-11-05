//
//  CurrentWeather.swift
//  ShinyDay
//
//  Created by 전율 on 11/4/24.
//

import Foundation
import UIKit

struct CurrentWeather:Codable {
    let dt: Int
    let weather: [Weather]
    let main: Main
    
    struct Weather:Codable {
        let id:Int
        let main:String
        let description:String
        let icon:String
    }
    
    struct Main:Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    
}

