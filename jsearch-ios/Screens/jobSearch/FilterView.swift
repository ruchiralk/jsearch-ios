//
//  FilterView.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-15.
//

import UIKit

class FilterView: UIView {
    
    class var defaultSize: CGSize {
        return CGSize(width: 180, height: 42)
    }
    
    lazy var filterButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.label, for: .normal)
        button.setTitle(NSLocalizedString("Filters", comment: "filters"), for: .normal)
        button.setImage(UIImage(named: "funnel"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 16)
        return button
    }()
    
    lazy var kaartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.label, for: .normal)
        button.setTitle(NSLocalizedString("Kaart", comment: "filters"), for: .normal)
        button.setImage(UIImage(named: "location"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        return button
    }()
    
    private lazy var separatorView: UIView = {
       let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    private lazy var contentView: UIStackView = {
       let view = UIStackView(arrangedSubviews: [filterButton, separatorView, kaartButton])
        view.axis = .horizontal
        view.distribution = .fill
        view.alignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        configureViews()
        addCornerRadius()
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        self.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        filterButton.snp.makeConstraints { make in
            make.width.equalTo(kaartButton.snp.width)
        }
        separatorView.snp.makeConstraints { make in
            make.width.equalTo(2)
            make.height.equalTo(self.snp.height).multipliedBy(0.7)
        }
        kaartButton.snp.makeConstraints { make in
            make.width.equalTo(filterButton.snp.width)
        }
    }
    
    private func addCornerRadius() {
        self.layer.cornerRadius = 20
    }
    
    private func addShadow() {
        self.layer.shadowColor = UIColor.separator.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 6
    }
}
