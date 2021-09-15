//
//  PresentingCoordinator.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit

// This Coordinator supports modal presentation
// Child coordinators expecting to do modal presentation should inherit from this
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
    
    override func finish(_ animated: Bool) {
        presentingViewController.dismiss(animated: animated)
        didFinish?(self)
    }
}

extension PresentingCoordinator: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        didFinish?(self)
    }
}
