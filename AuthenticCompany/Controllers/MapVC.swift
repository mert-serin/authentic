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
        m.showsUserLocation = true
        m.isUserInteractionEnabled = true
        return m
    }()
    
    var currentWeatherView:AWeatherInformationView?
    
    private var currentZoomScale = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        LocationManager.shared.askPermissionForLocationServices()
        NotificationCenter.default.addObserver(self, selector: #selector(getWeatherAfterLocationUpdate), name: Notification.Name(rawValue: "getWeatherAfterLocationUpdate"), object: nil)
        
        
    }
    
    @objc func getWeatherAfterLocationUpdate(){
        guard let locValue = LocationManager.shared.getLocValue() else {return}
        
        let region = MKCoordinateRegion(center: locValue, span: MKCoordinateSpan(latitudeDelta: currentZoomScale, longitudeDelta: currentZoomScale))
        let mapCamera = MKMapCamera(lookingAtCenter: locValue, fromDistance: 1000, pitch: 1000, heading: 1000)
        mapView.setCamera(mapCamera, animated: true)
        self.getDoubleTappedLocation(coordinate: locValue, shouldNavigate: false)
        self.mapView.setRegion(region, animated: false)
    }
    
    private func setupViews(){
        self.view.addSubview(mapView)
        
        mapView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(0)
        }
        
        //Double Tap Gesture for MapView
        let tapGesture = UITapGestureRecognizer(target: self, action:#selector(handleDoubleTap(_:)))
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 2
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleDoubleTap(_ sender: UIGestureRecognizer)
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
                self.promptAlert(title: "Error", message: "Error on retrieving weather data from Apixu please try again later", leftButtonTitle: "OK", leftButtonAction: nil, rightButtonTitle: nil, rightButtonAction: nil)
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
                    self.promptAlert(title: "Error", message: "Error on retrieving weather data from Apixu please try again later. Error: \(error)", leftButtonTitle: "OK", leftButtonAction: nil, rightButtonTitle: nil, rightButtonAction: nil)
                    return
                }
            }else{
                self.promptAlert(title: "Error", message: "Error on retrieving weather data from Apixu please try again later", leftButtonTitle: "OK", leftButtonAction: nil, rightButtonTitle: nil, rightButtonAction: nil)
                return
            }
        }
    }
    
    //Shows pop-up after first retrieve data from API
    private func showWeatherAfterAPIRequest(model:WeatherDataResponseModel){
        if currentWeatherView == nil{
            let v = AWeatherInformationView()
            self.view.addSubview(v)
            
            v.snp.makeConstraints { (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.bottom.equalTo(-20)
                make.height.equalTo(0)
            }
            
            v.snp.updateConstraints({ (make) in
                make.height.equalTo(100)
            })
            
            
            UIView.animate(withDuration: 0.2, delay: 0.5, options: UIViewAnimationOptions.curveEaseIn, animations: {
                v.layoutIfNeeded()
            })
            
            v.model = model
            self.currentWeatherView = v
            
        }else{
            currentWeatherView!.model = model
        }
    }


}
