//
//  PresentingCoordinator.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit

class PresentingCoordinator: Coordinator {
    
    let presentingViewController: UIViewController
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        super.init()
    }
    
    func present(
        viewController: UIViewController,
        animated: Bool,
        isModalInPresentation: Bool = false) {
        
        viewController.presentationController?.delegate = self
        viewController.isModalInPresentation = isModalInPresentation
        presentingViewController.present(viewController, animated: animated)
    }
    
    func finish(_ animated: Bool) {
        presentingViewController.dismiss(animated: animated)
        didFinish?(self)
    }
}

extension PresentingCoordinator: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        didFinish?(self)
    }
}
