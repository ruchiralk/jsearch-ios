//
//  Date+current.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-16.
//

import Foundation


internal var __date_currentImpl = { Date() }

extension Date {
    /// Return current date
    /// Please not that use of `Date()`  and  `Date(timeIntervalSinceNow:)` should be prohibited through
    // lin rules of commit hook, always use `Date.current`
    
    static var current: Date {
        return __date_currentImpl()
    }
}
