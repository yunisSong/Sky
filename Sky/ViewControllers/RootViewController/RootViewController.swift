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
    

    
    private lazy var locationManager : CLLocationManager = {
        let clManager = CLLocationManager()
        clManager.distanceFilter = 1000
        clManager.desiredAccuracy = 1000
        return clManager
    }()
    
    
    
    private var currentLocation: CLLocation? {
        didSet {
            
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

















