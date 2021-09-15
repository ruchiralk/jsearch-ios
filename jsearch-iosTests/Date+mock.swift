//
//  Date+mock.swift
//  jsearch-iosTests
//
//  Created by Ruchira on 2021-09-16.
//

import Foundation
@testable import jsearch_ios

// Mock current date to simplify testing
extension Date {
    
    // 1 January 2001
    static var mockDate: Date = Date(timeIntervalSinceReferenceDate: 0)

    static func overrideCurrentDate(_ currentDate: @autoclosure @escaping () -> Date) {
            __date_currentImpl = currentDate
    }
}
