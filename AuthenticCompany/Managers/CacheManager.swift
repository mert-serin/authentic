//
//  CacheManager.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import Foundation
import RealmSwift
class CacheManager{
    

    
    static let shared = CacheManager()
    var object:[WeatherCacheModel]{
        get{
            return retrieveAllObjects()
        }
    }
    
    init() {
        
    }
    
    func retrieveAllObjects() -> [WeatherCacheModel]{
        let realm = try! Realm()
        return Array(realm.objects(WeatherCacheModel.self))
    }
    
    func saveObject(model:WeatherCacheModel){
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(model)
        }
    }
}
