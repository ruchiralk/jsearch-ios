//
//  FlexJobDefaultRepository.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation
import RxSwift

class FlexJobDefaultRepository: FlexJobRepository {
    
    private let remoteDataSource: FlexJobsDataSource
    
    init(remoteDataSource: FlexJobsDataSource = FlexJobsRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchJobs(key: String) -> Observable<FlexJobResult?> {
        remoteDataSource.fetchJobs(key: key)
            .map { shifts in
                FlexJobResult(key: key,
                              data: shifts.map { FlexJob.from($0) })
            }
    }
}
