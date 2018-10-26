//
//  PreviousWeatherSearchVC.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import UIKit
import MapKit
class PreviousWeatherSearchVC: UIViewController {

    lazy var mapView:MKMapView = {
        var m = MKMapView()
        m.showsUserLocation = true
        return m
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .purple
    }
    
    private func setupViews(){
        self.view.addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
    }

}
