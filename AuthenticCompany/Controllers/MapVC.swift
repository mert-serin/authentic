//
//  MapVC.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import UIKit
import MapKit
class MapVC: UIViewController,UIGestureRecognizerDelegate{

    lazy var mapView:MKMapView = {
        var m = MKMapView()
        m.isZoomEnabled = false
        m.showsUserLocation = true
        m.isUserInteractionEnabled = true
        return m
    }()
    
    var currentWeatherView:AWeatherInformationView?
    
    private var currentZoomScale = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .yellow
        setupViews()
        LocationManager.shared.askPermissionForLocationServices()
        NotificationCenter.default.addObserver(self, selector: #selector(getWeatherAfterLocationUpdate), name: Notification.Name(rawValue: "getWeatherAfterLocationUpdate"), object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(MapVC.handleTap(_:)))
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func getWeatherAfterLocationUpdate(){
        guard let locValue = LocationManager.shared.getLocValue() else {return}
        
        let region = MKCoordinateRegion(center: locValue, span: MKCoordinateSpan(latitudeDelta: currentZoomScale, longitudeDelta: currentZoomScale))
        let mapCamera = MKMapCamera(lookingAtCenter: locValue, fromDistance: 1000, pitch: 1000, heading: 1000)
        mapView.setCamera(mapCamera, animated: true)
        
        self.getDoubleTappedLocation(coordinate: locValue, shouldNavigate: false)
        
        self.mapView.setRegion(region, animated: false)
    }
    
    private func showWeatherAfterAPIRequest(model:WeatherDataResponseModel){
        if currentWeatherView == nil{
            var v = AWeatherInformationView()
            self.view.addSubview(v)
            
            v.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.bottom.equalTo(-20)
                make.height.equalTo(100)
            }
            
            
            v.model = model
            self.currentWeatherView = v
            
        }else{
            currentWeatherView!.model = model
        }
    }
    
    private func setupViews(){
        self.view.addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer)
    {
        if sender.state == UIGestureRecognizerState.ended {
            
            let touchPoint = sender.location(in: mapView)
            let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            getDoubleTappedLocation(coordinate: touchCoordinate, shouldNavigate: true)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    private func getDoubleTappedLocation(coordinate:CLLocationCoordinate2D, shouldNavigate:Bool){
        APIManager().makeRequest(method: "GET", path: URLConstants.getWeatherDataURL + "?key=153693f66ced48d393b155828182610&q=\(coordinate.latitude),\(coordinate.longitude)", parameters: nil, headers: nil) { (response) in
            guard let json = response.object as? [String:AnyObject] else{
                //TO-DO alerts
                return
            }
            if response.isSuccess{
                do{
                    let model = try WeatherDataResponseModel(object: json)
                    if shouldNavigate{
                        let vc = WeatherDetailVC()
                        vc.model = model
                        CacheManager.shared.saveObject(model: model.convertToRealmObject())
                        self.present(vc, animated: true, completion: nil)
                    }else{
                        self.showWeatherAfterAPIRequest(model:model)
                    }
                    
                }catch{
                    //TO-DO alert
                    print(error)
                }
            }else{
                //TO-DO alert
                return
            }
        }
    }
    


}
