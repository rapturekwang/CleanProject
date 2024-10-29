//
//  UserSession.swift
//  CleanProject
//
//  Created by kwang on 10/28/24.
//

import Foundation
import Alamofire

public protocol SessionProtocol {
    func request(_ convertible: any URLConvertible,
                 method: HTTPMethod,
                 parameters: Parameters?,
                 headers: HTTPHeaders?) -> DataRequest
}

class UserSession: SessionProtocol {
    private let session: Session
    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .returnCacheDataElseLoad
        self.session = Session(configuration: config)
    }
    
    func request(_ convertible: any URLConvertible,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 headers: HTTPHeaders? = nil) -> DataRequest {
        session.request(convertible, method: method, parameters: parameters, headers: headers)
    }
}
