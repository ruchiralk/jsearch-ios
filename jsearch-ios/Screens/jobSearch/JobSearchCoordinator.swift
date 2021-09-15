//
//  JobSearchCoordinator.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit

class JobSearchCoordinator: NavigationCoordinator {
    
    override func start() {
        let viewModel = JobSearchViewModel()
        
        viewModel.login
            .subscribe { [weak self] _ in
                self?.showLogin()
            }
            .disposed(by: bag)
        
        viewModel.register
            .subscribe { [weak self] _ in
                self?.showRegister()
            }
            .disposed(by: bag)
        
        let view = JobSearchView()
        let viewController = JobSearchViewController(view, viewModel: viewModel)
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    private func showLogin() {
        let loginCoordinator = LoginCoordinator(
            presentingViewController: self.navigationController
        )
        pushCoordinator(loginCoordinator)
    }
    
    private func showRegister() {
        let registerCoordinator = RegisterCoordinator(
            presentingViewController: self.navigationController
        )
        pushCoordinator(registerCoordinator)
    }
}
