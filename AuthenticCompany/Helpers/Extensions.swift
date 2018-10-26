//
//  Extensions.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import Foundation
import MapKit
extension Int {
    func toAPIResponseType() -> APIResponseTypes {
        if self == 200 {
            return .Ok
        }
        else if self == 201 {
            return .Created
        }
        else if self == 400 {
            return .BadRequest
        }
        else if self == 401 {
            return .Unauthorized
        }
        else if self == 403 {
            return .Forbidden
        }
        else if self == 404 {
            return .NotFound
        }
        else if self == 405 {
            return .MethodNotAllowed
        }
        else if self == 409 {
            return .Conflict
        }
        else if self == 500 {
            return .InternalServerError
        }
        else if self == 503 {
            return .ServiceUnavailable
        }
        else {
            return .Undefined
        }
    }
}

extension CLLocationCoordinate2D{
    func ToCLLocation() -> CLLocation{
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIViewController{
    func promptAlert(title:String, message:String, leftButtonTitle:String, leftButtonAction:((UIAlertAction) -> Void)?, rightButtonTitle:String?, rightButtonAction:((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: leftButtonTitle, style: .cancel, handler: leftButtonAction))
        if rightButtonTitle != nil{
            alert.addAction(UIAlertAction(title: rightButtonTitle!, style: .default, handler: rightButtonAction))
        }
        
        
        self.present(alert, animated: true, completion: nil)
    }
}
