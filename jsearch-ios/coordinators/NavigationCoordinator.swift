//
//  NavigationCoordinator.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit

class NavigationCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    let initialViewController: UIViewController?
    
    init(navigationController: UINavigationController) {
        
        self.navigationController = navigationController
        self.initialViewController = self.navigationController.viewControllers.last
        super.init()
        self.navigationController.delegate = self
    }
    
    
    func finish(_ animated: Bool) {
        if let viewController = initialViewController {
            navigationController.popToViewController(viewController, animated: animated)
        } else {
            navigationController.popToRootViewController(animated: animated)
            didFinish?(self)
        }
    }
    
}

// MARK: - Navigation Control Delegate

extension NavigationCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController === initialViewController {
            didFinish?(self)
        }
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {}
}
