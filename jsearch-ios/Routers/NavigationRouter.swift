//
//  NavigationRouter.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-14.
//

import UIKit

public class NavigationRouter: NSObject {
    
    private let navigationController: UINavigationController
    private let routerRootController: UIViewController?
    private var onDismissForViewController: [UIViewController: (()->Void)] = [:]
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.routerRootController = navigationController.viewControllers.first
        super.init()
    }
}

extension NavigationRouter: Router {
    
    public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        onDismissForViewController[viewController] = onDismissed
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    public func dismiss(animated: Bool) {
        guard let routerRootController = routerRootController else {
            navigationController.popToRootViewController(animated: animated)
            return
        }
        performOnDismissed(for: routerRootController)
    }
    
    private func performOnDismissed(for viewController: UIViewController) {
        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
    
}
