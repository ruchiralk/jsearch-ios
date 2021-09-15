//
//  FlexJob.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation

struct FlexJob {
    let id: String
    let heroImage: String?
    let categoryName: String?
    let clientName: String?
    let shiftStartsAt: String?
    let shiftEndsAt: String?
    let earningsPerHour: Shift.EarningsPerHour?
    
    static func from(_ shift: Shift) -> FlexJob {
        FlexJob(id: shift.id,
                heroImage: shift.job?.project?.client?.links?.heroImage,
                categoryName: shift.job?.category?.name,
                clientName: shift.job?.project?.client?.name,
                shiftStartsAt: shift.startsAt,
                shiftEndsAt: shift.endsAt,
                earningsPerHour: shift.earningsPerHour)
    }
}
