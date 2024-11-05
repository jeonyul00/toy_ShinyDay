//
//  WeatherApi.swift
//  ShinyDay
//
//  Created by 전율 on 11/4/24.
//

import Foundation

class WeatherApi {
    enum Path:String {
        case weather
        case forecast
    }
    var summary: CurrentWeather?
    var forecastList = [ForecastData]()
    let dispathGroup = DispatchGroup() // 여러 작업을 하나로 묶는 역할
    
    private func fetch<T:Codable>(path:Path, lat: Double, lon: Double, completion: @escaping (Result<T,Error>)->Void){
        guard var url = URL(string: "https://api.openweathermap.org/data/2.5/\(path.rawValue)") else {
            completion(.failure(ApiError.invalidUrl(path.rawValue)))
            return
        }
        if #available(iOS 16.0, *) {
            url.append(queryItems: [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "kr"),
            ])
        } else {
            // 16 이전 버전
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "appid", value: apiKey),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "lang", value: "kr"),
            ]
            url = components?.url ?? url
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    guard let data else {
                        completion(.failure(ApiError.invalidResponse))
                        return
                    }
                    let decoder = JSONDecoder()
                    let result = try? decoder.decode(T.self, from: data)
                    if let result {
                        completion(.success(result))
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetch(lat: Double, lon:Double, completion: @escaping ()->Void) {
        dispathGroup.enter()
        
        fetch(path: .weather, lat: lat, lon: lon) { (result: Result<CurrentWeather, Error>) in
            switch result {
            case .success(let data):
                self.summary = data
            case .failure(_):
                self.summary = nil
            }
            self.dispathGroup.leave()
        }
        self.dispathGroup.enter()
        fetch(path: .forecast, lat: lat, lon: lon) { (result:Result<Forecast, Error>) in
            switch result {
            case .success(let data):
                self.forecastList = data.list.map {
                    let dt = Date(timeIntervalSince1970: TimeInterval($0.dt))
                    let icon = $0.weather.first?.icon ?? ""
                    let weather = $0.weather.first?.description ?? "알 수 없음"
                    let temperature = $0.main.temp
                    return ForecastData(date: dt, icon: icon, weather: weather, temperature: temperature)
                }
            case .failure(_):
                self.forecastList = []
            }
            self.dispathGroup.leave()
        }
        dispathGroup.notify(queue: .main) {
            completion()
        }
        
    }
    
    
}
