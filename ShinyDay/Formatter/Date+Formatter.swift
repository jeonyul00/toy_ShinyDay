//
//  Date+Formatter.swift
//  ShinyDay
//
//  Created by 전율 on 11/5/24.
//

import Foundation


fileprivate let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    return formatter
}()

extension Date {
    var dateString:String {
        dateFormatter.dateFormat = "M월 d일"
        return dateFormatter.string(from: self)
    }
    
    var timeString:String {
        dateFormatter.dateFormat = "HH:00"
        return dateFormatter.string(from: self)
    }
}
