//
//  TemperAPIService.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-16.
//

import Foundation
import RxSwift

protocol TemperAPIService {
    func fetchJobs(key: String) -> Observable<JobSearchResponse>
}
