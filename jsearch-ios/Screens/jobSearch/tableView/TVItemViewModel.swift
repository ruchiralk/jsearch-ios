//
//  TVItemViewModel.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-15.
//

import Foundation

struct TVItemViewModel {
    let heroImageUrl: String?
    let categoryName: String
    let clientName: String
    let duration: String
    let earnings: String
    
    static func from(_ flexJob: FlexJob) -> TVItemViewModel {
        
        let duration = extractDuration(startsAt: flexJob.shiftStartsAt,
                                       endsAt: flexJob.shiftEndsAt)
        
        return TVItemViewModel(heroImageUrl: flexJob.heroImage,
                               categoryName: flexJob.categoryName?.uppercased() ?? "",
                        clientName: flexJob.clientName ?? "",
                        duration: duration,
                        earnings: hourlyRate(earnings: flexJob.earningsPerHour))
    }
    
    static func extractDuration(startsAt: String?, endsAt: String?) -> String {
        guard let start = startsAt, let end = endsAt else {
            return ""
        }
        return "\(extractTime(dateTimeStr: start)) - \(extractTime(dateTimeStr: end))"
    }
    
    static func extractTime(dateTimeStr: String) -> String {
        let time = try? dateTimeStr.matching(regex: "((?:[01]\\d|2[0-3]):[0-5]\\d)").first
        return time ?? ""
    }
    
    static func hourlyRate(earnings: Shift.EarningsPerHour?) -> String {
        guard let amount = earnings?.amount, let currency = earnings?.currency else {
            return ""
        }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.currencyCode  = currency
        formatter.numberStyle = NumberFormatter.Style.currencyAccounting
        return formatter.string(from: NSNumber(value: amount)) ?? ""
    }
}
