//
//  JobSearchResponse.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation

// API result wrapper for jobSearch
struct JobSearchResponse: Codable {
    let data: [Shift]?
}
