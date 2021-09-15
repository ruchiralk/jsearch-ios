//
//  LoginCoordinator.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation

class LoginCoordinator: PresentingCoordinator {
    
    override func start() {
        let viewModel = LoginViewModel()
        let view = LoginView()
        let loginViewController = LoginViewController(view: view, viewModel: viewModel)
        present(viewController: loginViewController, animated: true)
    }
}
