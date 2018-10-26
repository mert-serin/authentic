//
//  WeahterCacheModel.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherCacheModel:Object{
    
    @objc dynamic var conditionIcon:String = ""
    @objc dynamic var conditionText:String = ""
    @objc dynamic var feelsLikeC:Double = 0.0
    @objc dynamic var feelsLikeF:Double = 0.0
    
    @objc dynamic var locationCountry:String = ""
    @objc dynamic var locationName:String = ""
    @objc dynamic var locationRegion:String = ""
    @objc dynamic var locationLat:Double = 0.0
    @objc dynamic var locationLon:Double = 0.0
 
    
    func covertToWeatherDataResponseModel() -> WeatherDataResponseModel{
        let dict = ["current":["feelslike_c":feelsLikeC, "feelslike_f": feelsLikeF, "condition":["text": conditionText, "icon": conditionIcon] ], "location":["country":locationCountry, "region": locationRegion, "name": locationName, "lat": locationLat, "lon": locationLon]]
        
        return try! WeatherDataResponseModel(object: dict)
    }
}
