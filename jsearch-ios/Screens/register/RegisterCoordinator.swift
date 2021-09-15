//
//  RegisterCoordinator.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation

class RegisterCoordinator: PresentingCoordinator {
    
    override func start() {
        let viewModel = RegisterViewModel()
        let view = RegisterView()
        let viewController = RegisterViewController(view: view, viewModel: viewModel)
        present(viewController: viewController, animated: true)
    }
}
