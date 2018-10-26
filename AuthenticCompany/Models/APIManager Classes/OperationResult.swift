//
//  OperationResult.swift
//  AuthenticCompany
//
//  Created by Mert Serin on 26.10.2018.
//  Copyright © 2018 Mert Serin. All rights reserved.
//

import Foundation
class OperationResult: NSObject {
    
    var message: String = ""
    var object: Any?
    var type: OperationResultTypes!
    var isSuccess: Bool { return type == OperationResultTypes.Success }
    var isApiResponseSuccess: Bool { return apiResponseType == .Ok || apiResponseType == .Created }
    var apiResponseType: APIResponseTypes = .Undefined
    
    override init() {
        super.init()
    }
    
}
