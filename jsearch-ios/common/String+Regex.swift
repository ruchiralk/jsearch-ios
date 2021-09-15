//
//  Regex.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-15.
//

import Foundation

extension String {
    
    func matching(regex: NSRegularExpression) throws -> [String] {
        let results = regex.matches(in: self,
                                    range: NSRange(self.startIndex..., in: self))
        return results.map{
            guard let range = Range($0.range, in: self) else {
                return ""
            }
            return String(self[range])
        }
    }
}
