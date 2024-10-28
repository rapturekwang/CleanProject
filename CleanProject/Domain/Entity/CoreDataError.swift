//
//  CoreDataError.swift
//  CleanProject
//
//  Created by kwang on 10/28/24.
//

import Foundation

public enum CoreDataError: Error {
    case entityNotFound(String)
    case saveError(String)
    case readError(String)
    case deleteError(String)
    
    public var description: String {
        switch self {
        case .entityNotFound(let objectName):
            "not found \(objectName)"
        case .saveError(let message):
            "save error \(message)"
        case .readError(let message):
            "read error \(message)"
        case .deleteError(let message):
            "delete error \(message)"
        }
    }
}
