//
//  Helpers.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//


import UIKit

func getColor(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat) -> UIColor{
    
    let c = CGFloat(255.0)
    
    return UIColor(red: r/c, green: g/c, blue: b/c, alpha: 1.0)
    
}

func checkIfiPhoneXOrNot() -> Bool{
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 1792,2436,2688:
            return true
        default:
            return false
        }
    }
    return false
}

func delay(seconds: Double, completion: @escaping () -> ()) {
    let popTime = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * seconds)) / Double(NSEC_PER_SEC)
    
    DispatchQueue.main.asyncAfter(deadline: popTime) {
        completion()
    }
}
