//
//  LoginCoordinator.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation
import RxSwift

class LoginCoordinator: PresentingCoordinator {
    
    override func start() {
        let viewModel = LoginViewModel()
        viewModel.onClose.subscribe { [weak self] _ in
            self?.finish(true)
        }.disposed(by: bag)

        let view = LoginView()
        let loginViewController = LoginViewController(view: view, viewModel: viewModel)
        present(viewController: loginViewController, animated: true)
    }
}
