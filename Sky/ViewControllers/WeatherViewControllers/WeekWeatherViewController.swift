//
//  WeekWeatherViewController.swift
//  Sky
//
//  Created by Yunis on 2018/6/13.
//  Copyright © 2018年 三十一. All rights reserved.
//

import UIKit

class WeekWeatherViewController: WeatherViewController {
    
    @IBOutlet weak var weekWeatherTableView: UITableView!

    
    var viewModel : WeekWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateView()  {
        activityIndicatorView.stopAnimating()
        
        if let _ = viewModel {
            updateWeatherDataContainer()
        }else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Load Location/Weather failed!"
        }
    }
    
    func updateWeatherDataContainer() {
        weatherContainerView.isHidden = false
        weekWeatherTableView.reloadData()
    }
    
}

//MARK: - UITableViewDataSource
extension WeekWeatherViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
            tableView.dequeueReusableCell(
                withIdentifier: WeekWeatherTableViewCell.reuseIdentifier,
                for: indexPath) as? WeekWeatherTableViewCell else {
                    fatalError("Unexpected table view cell")
        }
        
        if let vm = viewModel {
            cell.week.text = vm.week(for: indexPath.row)
            cell.date.text = vm.date(for: indexPath.row)
            cell.temperature.text = vm.temperature(for: indexPath.row)
            cell.weatherIcon.image = vm.weatherIcon(for: indexPath.row)
            cell.humid.text = vm.humidity(for: indexPath.row)
        }
        
        return cell
    }
    
    
}
