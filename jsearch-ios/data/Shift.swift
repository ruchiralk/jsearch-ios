//
//  Shift.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation

struct Shift: Codable {
    
    let earningsPerHour: EarningsPerHour?
    let endsAt: String?
    let id: String
    let job: Job?
    let startsAt: String?
    
    enum CodingKeys: String, CodingKey {
        case earningsPerHour = "earnings_per_hour"
        case endsAt = "ends_at"
        case id
        case job
        case startsAt = "starts_at"
    }
    
    struct EarningsPerHour: Codable {
        let amount: Double?
        let currency: String?
    }
    
    struct Job: Codable {
        let category: Category?
        let id: String
        let project: Project?
        let title: String?
    }
    
    struct Project: Codable {
        let client: Client?
        let id: String
        let name: String?
    }
    
    struct Category: Codable {
        let id: String
        let name: String?
    }
    
    struct Client: Codable {
        let description: String?
        let id: String
        let links: ClientLinks?
        let name: String?
    }
    
    struct ClientLinks: Codable {
        let heroImage: String?
        let thumbImage: String?
        
        enum CodingKeys: String, CodingKey {
            case heroImage = "hero_image"
            case thumbImage = "thumb_image"
        }
    }
}
