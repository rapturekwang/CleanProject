//
//  MockUserUsercase.swift
//  CleanProjectTests
//
//  Created by kwang on 10/31/24.
//

import Foundation
@testable import CleanProject

public class MockUserUsercase: UserListUsecaseProtocol {
    
    public var fetchUserResult: Result<UserListResult, NetworkError>?
    public var favoriteUserResult: Result<[UserListItem], CoreDataError>?
    
    public func fetchUser(query: String, page: Int) async -> Result<CleanProject.UserListResult, CleanProject.NetworkError> {
        fetchUserResult ?? .failure(.dataNil)
    }
    
    public func getFavoriteUsers() -> Result<[CleanProject.UserListItem], CleanProject.CoreDataError> {
        favoriteUserResult ?? .failure(.entityNotFound(""))
    }
    
    public func saveFavoriteUser(user: CleanProject.UserListItem) -> Result<Bool, CleanProject.CoreDataError> {
        .success(true)
    }
    
    public func deleteFavoriteUser(userID: Int) -> Result<Bool, CleanProject.CoreDataError> {
        .success(true)
    }
    
    public func checkFavoriteState(fetchUsers: [UserListItem], favoriteUsers: [UserListItem]) -> [(user: UserListItem, isFavorite: Bool)] {
        let favoriteSet = Set(favoriteUsers)
        return fetchUsers.map { user in
            if favoriteSet.contains(user) {
                return (user: user, isFavorite: true)
            } else {
                return (user: user, isFavorite: false)
            }
        }
    }
    
    public func convertListToDictionary(favoriteUsers: [UserListItem]) -> [String : [UserListItem]] {
        favoriteUsers.reduce(into: [String: [UserListItem]]()) { dict, user in
            if let firstString = user.login.first {
                let key = String(firstString).uppercased()
                dict[key, default: []].append(user)
            }
        }
    }
    
}
