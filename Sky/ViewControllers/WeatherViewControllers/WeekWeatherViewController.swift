//
//  WeekWeatherViewController.swift
//  Sky
//
//  Created by Yunis on 2018/6/13.
//  Copyright © 2018年 三十一. All rights reserved.
//

import UIKit

class WeekWeatherViewController: WeatherViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - UITableViewDataSource
extension WeatherViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =
            tableView.dequeueReusableCell(
                withIdentifier: WeekWeatherTableViewCell.reuseIdentifier,
                for: indexPath) as? WeekWeatherTableViewCell else {
                    fatalError("Unexpected table view cell")
        }
         return cell
    }
    
    
}
