//
//  MapVC.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import UIKit
import MapKit
class MapVC: UIViewController {

    lazy var mapView:MKMapView = {
        var m = MKMapView()
        m.showsUserLocation = true
        return m
    }()
    
    private var currentZoomScale = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .yellow
        setupViews()
        LocationManager.shared.askPermissionForLocationServices()
        NotificationCenter.default.addObserver(self, selector: #selector(getWeatherAfterLocationUpdate), name: Notification.Name(rawValue: "getWeatherAfterLocationUpdate"), object: nil)
    }
    
    @objc func getWeatherAfterLocationUpdate(){
        guard let locValue = LocationManager.shared.getLocValue() else {return}
        
        let region = MKCoordinateRegion(center: locValue, span: MKCoordinateSpan(latitudeDelta: currentZoomScale, longitudeDelta: currentZoomScale))
        let mapCamera = MKMapCamera(lookingAtCenter: locValue, fromDistance: 1000, pitch: 1000, heading: 1000)
        mapView.setCamera(mapCamera, animated: true)
        
        APIManager().makeRequest(method: "GET", path: URLConstants.getWeatherDataURL + "?key=153693f66ced48d393b155828182610&q=\(locValue.latitude),\(locValue.longitude)", parameters: nil, headers: nil) { (response) in
            print(response.object)
            if response.isSuccess{
                
            }else{
                
            }
        }
        
        self.mapView.setRegion(region, animated: false)
    }
    
    private func setupViews(){
        self.view.addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
    }

}
