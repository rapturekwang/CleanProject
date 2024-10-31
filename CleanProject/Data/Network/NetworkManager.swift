//
//  NetworkManager.swift
//  CleanProject
//
//  Created by kwang on 10/28/24.
//

import Foundation
import Alamofire

public protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters?) async -> Result<T, NetworkError>
}

public class NetworkManager: NetworkManagerProtocol {
    private let session: SessionProtocol
    init(session: SessionProtocol) {
        self.session = session
    }
    
    private let headers: HTTPHeaders = {
        let tokenArray = Bundle.main.object(forInfoDictionaryKey: "TokenArray") as? [String]
        let toekn = tokenArray?.reduce("") { $0 + $1 } ?? ""
        let tokenHeader = HTTPHeader(name: "Authorization", value: "Bearer ghp_\(toekn)")
        
        return HTTPHeaders([tokenHeader])
    }()
    
    public func fetchData<T: Decodable>(url: String, method: HTTPMethod, parameters: Parameters?) async -> Result<T, NetworkError> {
        guard let url = URL(string: url) else {
            return .failure(.urlError)
        }
        let result = await session.request(url, method: method, parameters: parameters, headers: headers).serializingData().response
        if let error = result.error { return .failure(.requestFailed(error.localizedDescription)) }
        guard let data = result.data else { return .failure(.dataNil) }
        guard let response = result.response else { return .failure(.invalidResponse) }
        if 200..<400 ~= response.statusCode {
            do {
                let data = try JSONDecoder().decode(T.self, from: data)
                return .success(data)
            } catch {
                return .failure(.failToDecode(error.localizedDescription))
            }
        } else {
            return .failure(.serverError(response.statusCode))
        }
    }
}
