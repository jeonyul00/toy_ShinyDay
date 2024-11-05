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
    var topInset:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        setupLayout()
        api.fetch(lat: 37.498206, lon: 127.02761) { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    // 뷰의 배치가 완료된 후
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if topInset == 0.0 {
            let first = IndexPath(item: 0, section: 0)
            if let cell = collectionView.cellForItem(at: first) {
                topInset = collectionView.frame.height - cell.frame.height - view.safeAreaInsets.bottom - 20
                var inset = collectionView.contentInset
                inset.top = topInset
                collectionView.contentInset = inset
                collectionView.selectItem(at: first, animated: false, scrollPosition: .bottom)
            }
        }
    }
    
}


// MARK: - leyout
extension ViewController {
    func setupLayout() {
        let summaryItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(180))
        let summaryItem = NSCollectionLayoutItem(layoutSize: summaryItemSize)
        let summaryGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(180))
        let summaryGroup = NSCollectionLayoutGroup.horizontal(layoutSize: summaryGroupSize, subitems: [summaryItem])
        let summarySection = NSCollectionLayoutSection(group: summaryGroup)
        summarySection.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        
        let forecastItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let forecastItem = NSCollectionLayoutItem(layoutSize: forecastItemSize)
        let forecastGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
        let forecastGroup = NSCollectionLayoutGroup.vertical(layoutSize: forecastGroupSize, subitems: [forecastItem])
        let forecastSection = NSCollectionLayoutSection(group: forecastGroup)
        forecastSection.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 10, trailing: 20)
        forecastSection.interGroupSpacing = 8
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            switch sectionIndex {
            case 0:
                return summarySection
            default:
                return forecastSection
            }
        }
        collectionView.collectionViewLayout = layout
    }
}

// MARK: - collectionView
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
