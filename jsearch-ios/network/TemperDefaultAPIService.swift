//
//  TemperAPIService.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation
import RxSwift

class TemperDefaultAPIService: TemperAPIService {
    
    private let apiClient: APIClient
    
    static let baseUrl = "https://temper.works/api/v3"
    
    init(apiClient: APIClient = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func fetchJobs(key: String) -> Observable<JobSearchResponse> {
        let filterParam = "filter[date]=\(key)".encode
        let url = "\(TemperDefaultAPIService.baseUrl)/shifts?\(filterParam)"
        return apiClient.get(url: url)
    }
}
