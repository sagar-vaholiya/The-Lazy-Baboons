//
//  Locator.swift
//  The Lazy Baboons
//
//  Created by Sagar Vaholiya on 18/12/18.
//  Copyright © 2018 Sagar Vaholiya. All rights reserved.
//

import Foundation
import CoreLocation


class Locator: NSObject, CLLocationManagerDelegate {
    enum Result <T> {
        case Success(T)
        case Failure(String)
    }
    
    static let shared: Locator = Locator()
    
    typealias Callback = (Result <Locator>) -> Void
    
    var requests: Array <Callback> = Array <Callback>()
    
    var location: CLLocation? { return sharedLocationManager.location  }
    
    lazy var sharedLocationManager: CLLocationManager = {
        let newLocationmanager = CLLocationManager()
        newLocationmanager.delegate = self
        
        return newLocationmanager
    }()
    
    // MARK: - Authorization
    
    class func authorize() { shared.authorize() }
    func authorize() { sharedLocationManager.requestWhenInUseAuthorization() }
    
    // MARK: - Helpers
    
    func locate(callback: @escaping Callback) {
        self.requests.append(callback)
        sharedLocationManager.startUpdatingLocation()
    }
    
    func reset() {
        self.requests = Array <Callback>()
        sharedLocationManager.stopUpdatingLocation()
    }
    
    // MARK: - Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        var errorMessage = ""
        if let clErr = error as? CLError {
            switch clErr {
            case CLError.locationUnknown:
               errorMessage = "Getting unknown location."
            case CLError.denied:
               errorMessage = "You denied location permission. Please allow it from settings."
            default:
               errorMessage = "other Core Location error"
            }
        } else {
               errorMessage = error.localizedDescription
        }
        
        
        for request in self.requests { request(.Failure(errorMessage)) }
        self.reset()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: Array <CLLocation>) {
        for request in self.requests { request(.Success(self)) }
        self.reset()
    }
    
}
