//
//  TemperApiService.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation
import RxCocoa
import RxSwift

class APIClient {
    
    static let shared = APIClient()
    
    private let decoder: JSONDecoder
    
    private init() {
        self.decoder = JSONDecoder()
    }
    
    func get<T: Decodable>(url: String) -> Observable<T> {
        
        guard let url = URL(string: url) else {
            return Observable.error(APIError.invalidURL)
        }
        
        return URLSession.shared.rx
            .response(request: URLRequest(url: url))
            .map { args -> T in
                let (response, data) = args
                if response.statusCode >= 200 && response.statusCode < 300 {
                    do {
                        return try self.decoder.decode(T.self, from: data)
                    } catch {
                        throw APIError.jsonParsingError(description: error.localizedDescription)
                    }
                } else {
                    throw APIError.responseError(
                        code: response.statusCode,
                        description: String.init(data: data, encoding: .utf8)
                    )
                }
            }
    }
}
