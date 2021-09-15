//
//  FlexJobsRemoteDataSource.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation
import RxSwift

public class FlexJobsRemoteDataSource: FlexJobsDataSource {
    
    private let temperService: TemperAPIService
    
    init(temperService: TemperAPIService = TemperDefaultAPIService()) {
        self.temperService = temperService
    }
    
    func fetchJobs(key: String) -> Observable<[Shift]> {
        temperService.fetchJobs(key: key)
            .map { $0.data ?? [] }
    }
}
