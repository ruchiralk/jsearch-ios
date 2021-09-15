//
//  FlexJobsDataSource.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation
import RxSwift

protocol FlexJobsDataSource {
    func fetchJobs(key: String) -> Observable<[Shift]>
}
