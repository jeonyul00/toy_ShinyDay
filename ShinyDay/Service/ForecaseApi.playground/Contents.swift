import UIKit

struct ForecaseApi:Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ListItem]
}

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

func fetchCurrentWeather(_ lat: Double, _ lon: Double){
    guard var url = URL(string: "https://api.openweathermap.org/data/2.5/forecast") else { fatalError() }
    
    url.append(queryItems: [
        URLQueryItem(name: "lat", value: "\(lat)"),
        URLQueryItem(name: "lon", value: "\(lon)"),
        URLQueryItem(name: "appid", value: "7369a051ad009f2778f95d145f0d3942"),
        URLQueryItem(name: "units", value: "metric"),
        URLQueryItem(name: "lang", value: "kr"),
    ])
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error { fatalError() }
        
        if let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                guard let data else { fatalError() }
                let decoder = JSONDecoder()
                let weather = try? decoder.decode(ForecaseApi.self, from: data)
                print(weather)
            }
        }
    }
    task.resume()
}

fetchCurrentWeather(37.498206, 127.027610)
