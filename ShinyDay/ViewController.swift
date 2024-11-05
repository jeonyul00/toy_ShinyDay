//
//  ViewController.swift
//  ShinyDay
//
//  Created by 전율 on 11/4/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let api = WeatherApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        api.fetch(lat: 37.498206, lon: 127.02761) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension ViewController:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return api.forecastList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SummaryCollectionViewCell", for: indexPath) as! SummaryCollectionViewCell
            if let weather = api.summary?.weather.first, let main = api.summary?.main {
                cell.weatherImageView.image = UIImage(named: weather.icon)
                cell.statusLabel.text = weather.description
                cell.minMaxLabel.text = "최고 \(main.temp_max.temperatureString) / 최저 \(main.temp_min.temperatureString)"
                cell.currentTemperaturelLabel.text = "\(main.temp.temperatureString)"
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as! ForecastCollectionViewCell
            let target = api.forecastList[indexPath.item]
            cell.dateLabel.text = target.date.dateString
            cell.timeLabel.text = target.date.timeString
            cell.weatherImageView.image = UIImage(named: target.icon)
            cell.statusLabel.text = target.weather
            cell.temperatureLabel.text = target.temperature.temperatureString
            return cell
        default:
            fatalError()
        }
    }
    
    
}
