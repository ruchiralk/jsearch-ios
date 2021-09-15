//
//  CurvedLabel.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-15.
//

import UIKit

class CurvedLabel: UIView {
    
    var text: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let height = self.bounds.height
        let width = self.bounds.width
        
        let path = UIBezierPath()
        // start from bottom
        path.move(to: CGPoint(x: 0, y: height))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: 20, y: 0))
        path.addCurve(
            to: CGPoint(x: 0, y: self.bounds.height),
            controlPoint1: CGPoint(x: 8, y: 0),
            controlPoint2: CGPoint(x: 8, y: bounds.height)
        )
        UIColor.white.setFill()
        path.fill()
        
        if let text = self.text {
            let attrStr = NSAttributedString(string: text, attributes: [
                                                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
            attrStr.draw(at: CGPoint(x: 16, y: 8))
        }
    }

}
