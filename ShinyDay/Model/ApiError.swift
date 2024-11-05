//
//  ApiError.swift
//  ShinyDay
//
//  Created by 전율 on 11/5/24.
//

import Foundation

enum ApiError:Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}
