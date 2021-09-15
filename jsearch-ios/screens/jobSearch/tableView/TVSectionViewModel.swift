//
//  JSSection.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-15.
//

import Foundation
import RxDataSources

struct TVSectionViewModel {
    let title: String
    var items: [TVItemViewModel]
    
    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEEE d MMMM"
        return formatter
    }()
    
    static func from(_ date: Date?, data: [FlexJob]) -> TVSectionViewModel {
        let title = formatDate(date)
        return TVSectionViewModel(title: title, items: data.map {TVItemViewModel.from($0) })
    }
    
    static func formatDate(_ date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        
        return formatter.string(from: date)
    }
}

extension TVSectionViewModel: SectionModelType {
    init(original: TVSectionViewModel, items: [TVItemViewModel]) {
        self = original
        self.items = items
    }
}
