//
//  WeatherDataResponseModel.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import Marshal

class WeatherDataResponseModel:Unmarshaling{
    
    var current:WeatherCurrentModel
    var location:WeatherLocationModel
    
    required init(object: MarshaledObject) throws {
        self.current = try object.value(for: "current")
        self.location = try object.value(for: "location")
    }
    
    func convertToRealmObject() -> WeatherCacheModel{
        var model = WeatherCacheModel()
        
        model.conditionIcon = current.condition.icon
        model.conditionText = current.condition.text
        model.feelsLikeC = current.feelsLikeC
        model.feelsLikeF = current.feelsLikeF
        model.locationCountry = location.country
        model.locationLat = location.lat
        model.locationLon = location.lon
        model.locationName = location.name
        model.locationRegion = location.region
        
        return model
    }
}

class WeatherCurrentModel:Unmarshaling{
    
    var feelsLikeC:Double
    var feelsLikeF:Double
    var condition:WeatherCurrentConditionModel
    
    required init(object: MarshaledObject) throws {
        self.feelsLikeC = try object.value(for: "feelslike_c")
        self.feelsLikeF = try object.value(for: "feelslike_f")
        self.condition = try object.value(for: "condition")
    }
}

class WeatherLocationModel:Unmarshaling{
    
    var country:String
    var region:String
    var name:String
    var lat:Double
    var lon:Double
    
    required init(object: MarshaledObject) throws {
        self.lat = try object.value(for: "lat")
        self.lon = try object.value(for: "lon")
        self.country = try object.value(for: "country")
        self.region = try object.value(for: "region")
        self.name = try object.value(for: "name")
    }
}

class WeatherCurrentConditionModel:Unmarshaling{
    
    var text:String
    var icon:String
    
    required init(object: MarshaledObject) throws {
        self.text = try object.value(for: "text")
        self.icon = try object.value(for: "icon")
    }
}
