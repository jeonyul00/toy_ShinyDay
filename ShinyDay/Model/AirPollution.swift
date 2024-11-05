//
//  AirPollution.swift
//  ShinyDay
//
//  Created by 전율 on 11/5/24.
//

import Foundation
import UIKit

struct AirPollution:Codable {
    let list: [Item]
 
}

struct Item:Codable {
    let main:Main
    let components: Components
}

struct Main:Codable {
    let aqi: Int
}

struct Components: Codable {    
    let o3: Double
    let pm2_5: Double
    let pm10: Double
}

extension AirPollution {
    var infoList: [DetailInfo] {
        return [
            DetailInfo(image: UIImage(systemName: "aqi.medium"), title: "대기질", value: "\(list.first?.main.aqi ?? 0)", description: "AQI"),
            DetailInfo(image: UIImage(systemName: "aqi.medium"), title: "오존", value: "\(list.first?.components.o3 ?? 0)", description: "O"),
            DetailInfo(image: UIImage(systemName: "aqi.medium"), title: "미세먼지", value: "\(list.first?.components.pm10 ?? 0)", description: "PM10"),
            DetailInfo(image: UIImage(systemName: "aqi.medium"), title: "초미세먼지", value: "\(list.first?.components.pm2_5 ?? 0)", description: "PM2.5"),
        ]
    }
}
