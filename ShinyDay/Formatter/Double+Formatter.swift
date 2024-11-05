//
//  Double+Formatter.swift
//  ShinyDay
//
//  Created by 전율 on 11/5/24.
//

import Foundation

fileprivate let temperatureFormatter: MeasurementFormatter = {
    let f = MeasurementFormatter()
    f.locale = Locale(identifier: "ko_kr")
    f.numberFormatter.maximumFractionDigits = 1
    f.unitOptions = .temperatureWithoutUnit
    return f
}()

extension Double {
    var temperatureString:String {
        let temp = Measurement<UnitTemperature>(value: self, unit: .celsius)
        return temperatureFormatter.string(from: temp)
    }
}
