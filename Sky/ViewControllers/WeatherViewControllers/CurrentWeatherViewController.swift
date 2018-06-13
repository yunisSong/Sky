//
//  CurrentWeatherViewController.swift
//  Sky
//
//  Created by Yunis on 2018/6/8.
//  Copyright © 2018年 三十一. All rights reserved.
//

import UIKit


protocol CurrentWeatherViewControllerDelegate: class {
    func locationButtonPressed(
        controller: CurrentWeatherViewController)
    func settingsButtonPressed(
        controller: CurrentWeatherViewController)
}

class CurrentWeatherViewController: WeatherViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: CurrentWeatherViewControllerDelegate?

    var viewModel : CurrentWeatherViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateView()  {
        activityIndicatorView.stopAnimating()
        
        if let vm = viewModel, vm.isUpdateReady   {
            updateWeatherContainer(with:vm)
        }else
        {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Cannot load fetch weather/location data from the network"
        }
    }

    func updateWeatherContainer(with vm: CurrentWeatherViewModel)  {
        
        weatherContainerView.isHidden = false

        locationLabel.text = vm.city
        temperatureLabel.text = vm.temperature
        weatherIcon.image = vm.weatherIcon
        humidityLabel.text = vm.humidity
        summaryLabel.text = vm.summary
        dateLabel.text = vm.date
        
    }
    

    @IBAction func locationButtonPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        delegate?.settingsButtonPressed(controller: self)
    }

}
