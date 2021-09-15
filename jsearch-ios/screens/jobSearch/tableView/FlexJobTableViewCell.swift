//
//  FlexJobTableViewCell.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-15.
//

import UIKit
import SnapKit
import Kingfisher

class FlexJobTableViewCell: UITableViewCell {
    
    class var cellHeight: CGFloat {
        return 288
    }
    
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var amountLabel: CurvedLabel = {
        let label = CurvedLabel()
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.secondary
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        return label
    }()
    
    lazy var clientNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
        return label
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:
                                        [categoryLabel, clientNameLabel, durationLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        layoutImageView()
        layoutAmountLabel()
        layoutStackView()
    }
    
    private func layoutImageView() {
        self.contentView.addSubview(heroImageView)
        heroImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(CGFloat.largeMargin)
            make.trailing.equalToSuperview().inset(CGFloat.largeMargin)
            make.top.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    private func layoutAmountLabel() {
        self.contentView.addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(heroImageView.snp.bottom)
            make.trailing.equalTo(heroImageView.snp.trailing)
            make.height.equalTo(24)
            make.width.equalTo(68)
        }
    }
    
    private func layoutStackView() {
        self.contentView.addSubview(detailsStackView)
        detailsStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(CGFloat.largeMargin)
            make.trailing.equalToSuperview().inset(CGFloat.largeMargin)
            make.bottom.equalToSuperview().inset(CGFloat.largeMargin)
            make.top.equalTo(self.heroImageView.snp.bottom).offset(CGFloat.largeMargin)
        }
    }
    
    func updateHeroImage(_ url: String?) {
        guard let url = url else {
            heroImageView.image = nil
            return
        }
        heroImageView.kf.setImage(with: URL(string: url))
    }
}
