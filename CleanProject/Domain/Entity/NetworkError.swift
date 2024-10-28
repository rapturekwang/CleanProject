//
//  NetworkError.swift
//  CleanProject
//
//  Created by kwang on 10/28/24.
//

import Foundation

public enum NetworkError: Error {
    case urlError
    case invalid
    case failToDecode(String)
    case dataNil
    case serverError(Int)
    case requestFailed(String)
    
    public var description: String {
        switch self {
        case .urlError:
            "URL error"
        case .invalid:
            "is not vailed"
        case .failToDecode(let description):
            "decode error \(description)"
        case .dataNil:
            "data is nil"
        case .serverError(let statusCode):
            "server error \(statusCode)"
        case .requestFailed(let message):
            "request failed \(message)"
        }
    }
}
