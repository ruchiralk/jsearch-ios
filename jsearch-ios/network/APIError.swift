//
//  APIError.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation

enum APIError: Error {
    case responseError(code: Int, description: String?)
    case jsonParsingError(description: String)
    case invalidURL
}
