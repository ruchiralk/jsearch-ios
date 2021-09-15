//
//  LoginViewController.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private let loginView: LoginView
    private let viewModel: LoginViewModel
    
    private let bag = DisposeBag()
    
    init(view: LoginView, viewModel: LoginViewModel) {
        self.loginView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.viewDidLoad()
        configureOnClose()
    }
    
    private func configureOnClose() {
        loginView
            .closeButton.rx.tap
            .bind(to: viewModel.onClose)
            .disposed(by: bag)
    }
}
