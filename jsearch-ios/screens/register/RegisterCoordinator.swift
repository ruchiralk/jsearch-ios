//
//  RegisterCoordinator.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import Foundation
import RxSwift

class RegisterCoordinator: PresentingCoordinator {
    
    override func start() {
        let viewModel = RegisterViewModel()
        viewModel.onClose.subscribe { [weak self] _ in
            self?.finish(true)
        }.disposed(by: bag)
        
        let view = RegisterView()
        let viewController = RegisterViewController(view: view, viewModel: viewModel)
        present(viewController: viewController, animated: true)
    }
}
