//
//  MockUserRepository.swift
//  CleanProjectTests
//
//  Created by kwang on 10/29/24.
//

import Foundation
@testable import CleanProject

public struct MockUserRepository: UserRepositoryProtocol {
    public func fetchUser(query: String, page: Int) async -> Result<CleanProject.UserListResult, CleanProject.NetworkError> {
        .failure(.dataNil)
    }
    
    public func getFavoriteUsers() -> Result<[CleanProject.UserListItem], CleanProject.CoreDataError> {
        .failure(.entityNotFound(""))
    }
    
    public func saveFavoriteUser(user: CleanProject.UserListItem) -> Result<Bool, CleanProject.CoreDataError> {
        .failure(.entityNotFound(""))
    }
    
    public func deleteFavoriteUser(userID: Int) -> Result<Bool, CleanProject.CoreDataError> {
        .failure(.entityNotFound(""))
    }
    
}
