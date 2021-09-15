//
//  FWButton.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit

class FWButton: UIButton {
    
    class var defaultHeight: CGFloat {
        return 40.0
    }
    
    init(frame: CGRect,
         backgroundColor: UIColor = UIColor.primary,
         textColor: UIColor = UIColor.primaryOnColor) {
        
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        addCornerRadius()
        self.backgroundColor = backgroundColor
        self.setTitleColor(textColor, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addCornerRadius()
    }
    
    private func addCornerRadius() {
        layer.cornerRadius = 5
    }
}
