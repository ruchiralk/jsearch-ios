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
      
        return formatter
    }()
    
    static func from(_ date: String?, data: [FlexJob]) -> TVSectionViewModel {
        let title = formatDate(date)
        return TVSectionViewModel(title: title, items: data.map {TVItemViewModel.from($0) })
    }
    
    static func formatDate(_ dateStr: String?) -> String {
        guard let dateStr = dateStr else {
            return ""
        }
        
        formatter.dateFormat = JobSearchViewModel.serverDateFormat
        guard let date = formatter.date(from: dateStr) else {
            return ""
        }
        
        formatter.dateFormat = "EEEE d MMMM"
        return formatter.string(from: date)
    }
}

extension TVSectionViewModel: SectionModelType {
    init(original: TVSectionViewModel, items: [TVItemViewModel]) {
        self = original
        self.items = items
    }
}
