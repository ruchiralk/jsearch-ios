//
//  FakeFlexJobRepository.swift
//  jsearch-iosTests
//
//  Created by Ruchira on 2021-09-15.
//

import Foundation
import RxSwift
@testable import jsearch_ios

class FakeFlexJobRepository: FlexJobRepository {
    
    static let Result_2001_01_01 = FlexJobResult(key: "2001-01-01", data: [])
    static let Result_2001_01_02 = FlexJobResult(key: "2001-01-02", data: [])
    static let Result_2001_01_03 = FlexJobResult(key: "2001-01-03", data: [])
    static let Result_2001_01_04 = FlexJobResult(key: "2001-01-04", data: [])
    static let Result_2001_01_05 = FlexJobResult(key: "2001-01-05", data: [])
    
    private let data = [Result_2001_01_01.key : Result_2001_01_01,
                        Result_2001_01_02.key : Result_2001_01_02,
                        Result_2001_01_03.key : Result_2001_01_03,
                        Result_2001_01_04.key : Result_2001_01_04,
                        Result_2001_01_05.key : Result_2001_01_05]
    
    var error: Error?
    
    func fetchJobs(key: String) -> Observable<FlexJobResult?> {
        if error == nil {
            return Observable.just(data[key])
        } else {
            return Observable.error(error!)
        }
    }
}

extension FlexJobResult {
    func model() -> TVSectionViewModel {
        TVSectionViewModel.from(self.key, data: self.data)
    }
}

extension TVSectionViewModel: Equatable {
    public static func == (lhs: TVSectionViewModel, rhs: TVSectionViewModel) -> Bool {
        return lhs.title == rhs.title
    }
}
