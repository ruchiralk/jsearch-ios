//
//  RegisterViewController.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let registerView: RegisterView
    private let viewModel: RegisterViewModel
    
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
        self.view.backgroundColor = .darkGray
    }
}
