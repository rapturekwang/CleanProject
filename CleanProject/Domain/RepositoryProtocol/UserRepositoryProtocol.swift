//
//  UserRepositoryProtocol.swift
//  CleanProject
//
//  Created by kwang on 10/28/24.
//

import Foundation

public protocol UserRepositoryProtocol {
    func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError>
    func getFavoriteUsers() -> Result<[UserListItem], CoreDataError>
    func saveFavoriteUser(user: UserListItem) -> Result<Bool, CoreDataError>
    func deleteFavoriteUser(userID: Int) -> Result<Bool, CoreDataError>
}
