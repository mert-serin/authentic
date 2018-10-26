//
//  LocationManager.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import Foundation
import MapKit

class LocationManager:NSObject,CLLocationManagerDelegate{
    
    static let shared = LocationManager()
    let locationManager = CLLocationManager()
    private var locValue: CLLocationCoordinate2D?
    private var distanceBetweenCoordinates:Double = 100.0 //meter
    
    override init() {
        
    }
    
    func askPermissionForLocationServices(){
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLoc = manager.location?.coordinate else {return}
        if locValue?.latitude != newLoc.latitude || locValue?.longitude != newLoc.longitude{
            
        }
        
        //If user's location changes more than distanceBetwenCoordinates, we'll send notification to update current location's weather
        if locValue == nil || checkDistance(newLoc: newLoc){
            self.locValue = newLoc
            NotificationCenter.default.post(name: Notification.Name(rawValue: "getWeatherAfterLocationUpdate"), object: nil)
        }
    }
    
    func getLocValue() -> CLLocationCoordinate2D?{
        return locValue
    }
    
    func checkDistance(newLoc:CLLocationCoordinate2D) -> Bool{
        guard let l = locValue else {return false}
        
        let distanceInMeters = l.ToCLLocation().distance(from: newLoc.ToCLLocation()).roundTo(places: 0)
        
        if distanceInMeters >= distanceBetweenCoordinates{
            return true
        }
        
        return false
    }
    
}
