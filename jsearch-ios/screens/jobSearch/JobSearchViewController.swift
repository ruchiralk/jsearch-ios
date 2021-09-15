//
//  JobSearchViewController.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NotificationBannerSwift

class JobSearchViewController: UIViewController {
    
    private let viewModel: JobSearchViewModel
    private let jobSearchView: JobSearchView
    
    let datasource = RxTableViewSectionedReloadDataSource<TVSectionViewModel>(
        configureCell:  { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: FlexJobTableViewCell.identifier) as! FlexJobTableViewCell
            cell.updateHeroImage(element.heroImageUrl)
            cell.categoryLabel.text = element.categoryName
            cell.clientNameLabel.text = element.clientName
            cell.durationLabel.text = element.duration
            cell.amountLabel.text = element.earnings
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].title
        }
    )
    
    private let bag = DisposeBag()
    
    init(_ view: JobSearchView, viewModel: JobSearchViewModel) {
        self.viewModel = viewModel
        self.jobSearchView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        self.view = jobSearchView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobSearchView.viewDidLoad()
        showProgressIndicatorWhenActive()
        configureLogin()
        configureRegister()
        configureTableView()
        showErrors()
    }
    
    private func configureLogin() {
        jobSearchView
            .loginButton.rx.tap
            .bind(to: viewModel.login)
            .disposed(by: bag)
    }
    
    private func configureRegister() {
        jobSearchView
            .signUpButton.rx.tap
            .bind(to: viewModel.register)
            .disposed(by: bag)
    }
    
    private func showProgressIndicatorWhenActive() {
        viewModel.isActive
            .drive { [weak self] active in
                if active {
                    let activityView = UIActivityIndicatorView(style: .large)
                    activityView.startAnimating()
                    self?.jobSearchView.tableView.tableFooterView = activityView
                } else {
                    self?.jobSearchView.tableView.tableFooterView = nil
                }
            }
            .disposed(by: bag)
    }
    
    private func showErrors() {
        viewModel.error
            .drive(onNext: { error in
                guard let error = error else {
                    return
                }
                NotificationBanner(title: NSLocalizedString("Errpr", comment: "error"),
                                   subtitle: error.localizedDescription,
                                   style: .danger
                )
                .show()
            })
            .disposed(by: bag)
    }
}

extension JobSearchViewController: UITableViewDelegate {
    
    // MARK: - TableView Configurations
    
    private func configureTableView() {
        jobSearchView.tableView.register(FlexJobTableViewCell.self,
                                         forCellReuseIdentifier: FlexJobTableViewCell.identifier)
        jobSearchView.tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: UITableViewHeaderFooterView.identifier)
        
        jobSearchView.tableView.rx
            .setDelegate(self)
            .disposed(by: bag)
        
        bindTableViewLoadMore()
        bindPullToRefresh()
        bindTableViewDataSource()
        bindRefreshControl()
    }
    
    private func bindTableViewLoadMore() {
        jobSearchView.tableView.rx
            .reachedBottom()
            .bind(to: viewModel.loadMore)
            .disposed(by: bag)
        
    }
    
    private func bindPullToRefresh() {
        jobSearchView.tableView
            .refreshControl?.rx
            .controlEvent(.valueChanged)
            .bind(to: viewModel.refresh)
            .disposed(by: bag)
    }
    
    private func bindRefreshControl() {
        viewModel.isActive
            .skip(1)
            .asObservable()
            .bind(to: jobSearchView.tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: bag)
    }
    
    private func bindTableViewDataSource() {
        viewModel.results
            .asObservable()
            .bind(to: jobSearchView.tableView.rx.items(dataSource: self.datasource))
            .disposed(by: bag)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view =  tableView.dequeueReusableHeaderFooterView(withIdentifier:  UITableViewHeaderFooterView.identifier)
        
        var backgroundConfig = UIBackgroundConfiguration.listPlainHeaderFooter()
        backgroundConfig.backgroundColor = .systemBackground
        
        view?.backgroundConfiguration = backgroundConfig
        return view
    }
}
