//
//  URLConstants.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import Foundation
class URLConstants {
    
    // TODO: NEVER FORGET TO MODIFY HERE! (do NOT remove this comment line ever!)
    internal static let environment: Environments = Environments.Live
    
    private static let _server = URLConstants.getURL()
    private static let _endPoint = "\(_server)"
    
    static let getWeatherDataURL = "\(_endPoint)/current.json"
    
    private static func getURL() -> String {
        
        switch environment {
        case .Local:
            return ""
            
        case .Test:
            return ""
            
        case .Live:
            return "https://api.apixu.com/v1"
        }
    }
    
}
