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
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.numberStyle = NumberFormatter.Style.currencyAccounting
        return formatter
    }()
    
    // API returns startTime and endTime in muliple format
    // Using this regex instead of DateFormatters to simplyfy time extraction
    private static let timeExtractionRegex: NSRegularExpression? = {
        try? NSRegularExpression(pattern: "((?:[01]\\d|2[0-3]):[0-5]\\d)")
    }()
    
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
    
    // Extract time from any datetime string
    static func extractTime(dateTimeStr: String) -> String {
        guard let regex = timeExtractionRegex else {
            return ""
        }
        let time = try? dateTimeStr.matching(regex: regex).first
        return time ?? ""
    }
    
    static func hourlyRate(earnings: Shift.EarningsPerHour?) -> String {
        guard let amount = earnings?.amount, let currency = earnings?.currency else {
            return ""
        }
        numberFormatter.currencyCode  = currency
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
}
