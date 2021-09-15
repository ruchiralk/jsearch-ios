//
//  FWOutlineButton.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit

class FWOutlineButton: FWButton {

    init(frame: CGRect,
         borderColor: UIColor = .black,
         borderWidth: CGFloat = 1.0,
         backgroundColor: UIColor = .white,
         textColor: UIColor = .black) {
        
        super.init(frame: frame,
                   backgroundColor: backgroundColor,
                   textColor: textColor)
        addOutline(withColor: borderColor, borderWidth: borderWidth)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addOutline(withColor color: UIColor, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    
}
