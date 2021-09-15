//
//  RegisterViewController.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    private let registerView: RegisterView
    private let viewModel: RegisterViewModel
    
    private let bag = DisposeBag()
    
    init(view: RegisterView, viewModel: RegisterViewModel) {
        self.registerView = view
        self.viewModel  = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.viewDidLoad()
        configureOnClose()
    }
    
    private func configureOnClose() {
        registerView
            .closeButton.rx.tap
            .bind(to: viewModel.onClose)
            .disposed(by: bag)
    }
}
