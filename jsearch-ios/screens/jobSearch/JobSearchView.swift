//
//  JobSearchView.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit
import SnapKit

class JobSearchView: UIView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.refreshControl = UIRefreshControl()
        tableView.separatorStyle = .none
        tableView.rowHeight = FlexJobTableViewCell.cellHeight
        tableView.allowsSelection = false
        return tableView
    }()
    
    lazy var loginButton: FWOutlineButton = {
        let button = FWOutlineButton(frame: .zero)
        button.setTitle(NSLocalizedString("Log in", comment: "Log in"), for: .normal)
        return button
    }()
    
    lazy var signUpButton: FWButton = {
        let button = FWButton(frame: .zero)
        button.setTitle(NSLocalizedString("Sign up", comment: "sign up"), for: .normal)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpButton, loginButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 24
        return stackView
    }()
    
    lazy var filterView: FilterView = {
        let view = FilterView()
        return view
    }()
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewDidLoad() {
        self.backgroundColor = .systemBackground
        layoutButtonStack()
        layoutTableView()
        layoutFilterView()
    }
    
    private func layoutTableView() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.buttonStackView.snp.top).inset(-CGFloat.largeMargin)
        }
    }
    
    private func layoutButtonStack() {
        self.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.leading
                .equalToSuperview().inset(CGFloat.largeMargin)
            make.trailing
                .equalToSuperview().inset(CGFloat.largeMargin)
            make.bottom
                .equalTo(self.safeAreaLayoutGuide.snp.bottom)
                .inset(CGFloat.smallMargin)
            make.height
                .equalTo(FWButton.defaultHeight)
        }
    }
    
    private func layoutFilterView() {
        self.addSubview(filterView)
        filterView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom
                .equalTo(self.tableView.snp.bottom)
                .inset(40)
            make.width.equalTo(FilterView.defaultSize.width)
            make.height.equalTo(FilterView.defaultSize.height)
        }
    }
}
