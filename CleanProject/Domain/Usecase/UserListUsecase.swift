//
//  UserListUsecase.swift
//  CleanProject
//
//  Created by kwang on 10/28/24.
//

import Foundation

public protocol UserListUsecaseProtocol {
    func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError>
    func getFavoriteUsers() -> Result<[UserListItem], CoreDataError>
    func saveFavoriteUser(user: UserListItem) -> Result<Bool, CoreDataError>
    func deleteFavoriteUser(userID: Int) -> Result<Bool, CoreDataError>
    //유저리스트 - 즐겨찾기 포함된 유저인지
    func checkFavoriteState(fetchUsers: [UserListItem], favoriteUsers: [UserListItem]) -> [(user: UserListItem, isFavorite: Bool)]
    //배열 -> Dictionary [초성: [유저리스트]]
    func convertListToDictionary(favoriteUsers: [UserListItem]) -> [String: [UserListItem]]
}

public struct UserListUsecase: UserListUsecaseProtocol {
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    public func fetchUser(query: String, page: Int) async -> Result<UserListResult, NetworkError> {
        await repository.fetchUser(query: query, page: page)
    }
    
    public func getFavoriteUsers() -> Result<[UserListItem], CoreDataError> {
        repository.getFavoriteUsers()
    }
    
    public func saveFavoriteUser(user: UserListItem) -> Result<Bool, CoreDataError> {
        repository.saveFavoriteUser(user: user)
    }
    
    public func deleteFavoriteUser(userID: Int) -> Result<Bool, CoreDataError> {
        repository.deleteFavoriteUser(userID: userID)
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
