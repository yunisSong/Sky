//
//  ViewController.swift
//  Sky
//
//  Created by Mars on 28/09/2017.
//  Copyright © 2017 Mars. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {

    private let segueCurrentWeather = "SegueCurrentWeather"
    var currentWeatherViewController : CurrentWeatherViewController!
    
    
    private lazy var locationManager : CLLocationManager = {
        let clManager = CLLocationManager()
        clManager.distanceFilter = 1000
        clManager.desiredAccuracy = 1000
        return clManager
    }()

    private var currentLocation: CLLocation? {
        didSet {
            fetchCity()
            fetchWeather()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let identifier = segue.identifier else {return}
        
        switch identifier {
        case segueCurrentWeather:
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError("Invalid destination view controller!")
            }
            destination.delegate = self
            destination.viewModel = CurrentWeatherViewModel()
            currentWeatherViewController = destination
            
            
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //接收地理位置信息的通知
        setUpActiveNotification()
        //app进入前台
        
        //请求地理位置
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func  applicationDidBecomeActive(notification: Notification) {
        requestLocation()
    }
    
    private func setUpActiveNotification()  {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RootViewController.applicationDidBecomeActive(notification:)),
            name: Notification.Name.UIApplicationDidBecomeActive,
            object: nil)
        
    }
    
    private func fetchCity() {
        
        guard let currentLocation = currentLocation else {
            return
        }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let error = error {
                dump(error)
            }else if let city = placemarks?.first?.locality {
                // Todo: 通知 当前天气控制器
                self.currentWeatherViewController.viewModel?.location = Location(
                    name: city,
                    latitude: currentLocation.coordinate.latitude,
                    longitude: currentLocation.coordinate.longitude)
                
            }
        }
    }
    
    private func fetchWeather() {
        guard let currentLocation = currentLocation else {
            return
        }
        
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lat, longitude: lon) { (response, error) in
            
            if let error = error {
                dump(error)
            }else if let response = response {
                // Todo: 通知 当前天气控制器
                self.currentWeatherViewController.viewModel?.weather = response
            }
        }
    }

}

// MARK: - CLLocationManagerDelegate
extension RootViewController : CLLocationManagerDelegate {
    
    private func requestLocation() {
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse
        {
            locationManager.requestLocation()
        }else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            currentLocation = location
            manager.delegate = nil
            manager.stopUpdatingHeading()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        dump(error)
    }
    
}

// MARK: - CurrentWeatherViewControllerDelegate
extension RootViewController : CurrentWeatherViewControllerDelegate {
    
    func locationButtonPressed(controller: CurrentWeatherViewController) {
        print("open locations.")
    }
    
    func settingsButtonPressed(controller: CurrentWeatherViewController) {
        print("open Settings.")
    }
}














