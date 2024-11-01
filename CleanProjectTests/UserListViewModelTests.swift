//
//  UserListViewModelTests.swift
//  CleanProjectTests
//
//  Created by kwang on 10/31/24.
//

import Foundation
import XCTest
@testable import CleanProject
import RxSwift
import RxCocoa

final class UserListViewModelTests: XCTest {
    
    private var viewModel: UserListViewModel!
    private var mockUsercase: MockUserUsercase!
    
    private var tabButtonType: BehaviorRelay<TabButtonType>!
    private var query: BehaviorRelay<String>!
    private var saveFavorite: PublishRelay<UserListItem>!
    private var deleteFavorite: PublishRelay<Int>!
    private var fetchMore: PublishRelay<Void>!
    private var input: UserListViewModel.Input!
    
    private var disposeBag: DisposeBag!
    override func setUp() {
        super.setUp()
        mockUsercase = MockUserUsercase()
        viewModel = UserListViewModel(usecase: mockUsercase)
        tabButtonType = BehaviorRelay(value: .api)
        query = BehaviorRelay(value: "")
        saveFavorite = PublishRelay()
        deleteFavorite = PublishRelay()
        fetchMore = PublishRelay()
        
        input = UserListViewModel.Input(tabButtonType: tabButtonType.asObservable(), query: query.asObservable(), saveFavorite: saveFavorite.asObservable(), deleteFavorite: deleteFavorite.asObservable(), fetchMore: fetchMore.asObservable())
    }
    
    func testFetchUserCelldata() {
        let userList = [
            UserListItem(id: 1, login: "user1", imageURL: ""),
            UserListItem(id: 2, login: "user2", imageURL: ""),
            UserListItem(id: 3, login: "user3", imageURL: ""),
        ]
        mockUsercase.fetchUserResult = .success(UserListResult(totalCount: 3, incompleteResults: false, items: userList))
        
        let output = viewModel.transform(input: input)
        query.accept("user")
        var result: [UserListCellData] = []
        output.cellData.bind { cellData in
            result = cellData
        }.disposed(by: disposeBag)
        
        if case .user(let userItem, _) = result.first {
            XCTAssertEqual(userItem.login, "user1")
        } else {
            XCTFail("Cell Data user cell not")
        }
    }
    
    func testFavoriteUserCelldata() {
        let userList = [
            UserListItem(id: 1, login: "Ash", imageURL: ""),
            UserListItem(id: 2, login: "Brown", imageURL: ""),
            UserListItem(id: 3, login: "Brad", imageURL: ""),
        ]
        mockUsercase.favoriteUserResult = .success(userList)
        let output = viewModel.transform(input: input)
        tabButtonType.accept(.favorite)
        
        var result: [UserListCellData] = []
        output.cellData.bind { cellData in
            result = cellData
        }.disposed(by: disposeBag)
        
        if case let .header(key) = result.first {
            XCTAssertEqual(key, "A")
        } else {
            XCTFail("Cell data header cell not")
        }
        
        if case .user(let userItem, let isFavorite) = result[1] {
            XCTAssertEqual(userItem.login, "Ash")
            XCTAssertTrue(isFavorite)
        } else {
            XCTFail("Cell data user cell not")
        }
    }
    
    override func tearDown() {
        viewModel = nil
        mockUsercase = nil
        disposeBag = nil
        super.tearDown()
    }
}
