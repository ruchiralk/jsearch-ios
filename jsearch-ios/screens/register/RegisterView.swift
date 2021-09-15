//
//  RegisterView.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit
import SnapKit

class RegisterView: UIView {
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Close", comment: "close"), for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidLoad() {
        self.backgroundColor = .systemBackground
        configureCloseButton()
    }
    
    private func configureCloseButton() {
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(CGFloat.largeMargin)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(CGFloat.largeMargin)
        }
    }
}
