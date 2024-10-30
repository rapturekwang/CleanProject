//
//  UserListViewModel.swift
//  CleanProject
//
//  Created by kwang on 10/29/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserListViewModelProtocol {
    
}

public final class UserListViewModel: UserListViewModelProtocol {
    private let usecase: UserListUsecaseProtocol
    private let disposeBag = DisposeBag()
    private let error = PublishRelay<String>()
    private let fetchUserList = BehaviorRelay<[UserListItem]>(value: [])
    private let allFavoriteUserList = BehaviorRelay<[UserListItem]>(value: [])
    private let favoriteUserList = BehaviorRelay<[UserListItem]>(value: [])
    
    public init(usecase: UserListUsecaseProtocol) {
        self.usecase = usecase
    }
    
    //이벤트(VC) -> 가공 or 외부에서 데이터 호출 or 뷰 데이터를 전달 (VM) -> VC
    public struct Input {
        let tabButtonType: Observable<TabButtonType>
        let query: Observable<String>
        let saveFavorite: Observable<UserListItem>
        let deleteFavorite: Observable<Int>
        let fetchMore: Observable<Void>
    }
    public struct Output {
        let cellData: Observable<[UserListCellData]>
        let error: Observable<String>
    }
    
    public func transform(input: Input) -> Output {
        input.query.bind { query in
            
        }.disposed(by: disposeBag)
        
        input.saveFavorite.bind { user in
            
        }.disposed(by: disposeBag)
        
        input.deleteFavorite.bind { userID in
            
        }.disposed(by: disposeBag)
        
        input.fetchMore.bind {
            
        }.disposed(by: disposeBag)
        
        let cellData: Observable<[UserListCellData]> = Observable.combineLatest(input.tabButtonType, fetchUserList, favoriteUserList).map { tabButtonType, fetchUserList, favoriteUserList in
            let cellData: [UserListCellData] = []
            return cellData
        }
        
        return Output(cellData: cellData, error: error.asObservable())
    }
}

public enum TabButtonType {
    case api
    case favorite
}

public enum UserListCellData {
    case user(user: UserListItem, isFavorite: Bool)
    case header(String)
}
