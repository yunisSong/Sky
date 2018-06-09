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

    
    var now : WeatherData? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    var location :Location? {
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
        
        if let now = now , let location = location{
            updateWeatherContainer(with: now, at: location)
        }else
        {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "Cannot load fetch weather/location data from the network"
        }
    }

    func updateWeatherContainer(with data:WeatherData,at location:Location)  {
        weatherContainerView.isHidden = false
        
        locationLabel.text = location.name
        
        temperatureLabel.text = String.init(format: "%.1f", data.currently.temperature.toCelcius())
        
    
        weatherIcon.image = weatherIcon(of: data.currently.icon)
        humidityLabel.text = String(
            format: "%.1f",
            data.currently.humidity)
        
        summaryLabel.text = data.currently.summary
        
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM"
        dateLabel.text = formatter.string(
            from: data.currently.time)
        
    }
    

    @IBAction func locationButtonPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        delegate?.settingsButtonPressed(controller: self)
    }

}
