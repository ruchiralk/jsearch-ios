//
//  AppCoordinator.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-12.
//

import UIKit

class AppCoordinator: Coordinator {

    var rootViewController: UIViewController {
        return navigationController
    }
    
    private let navigationController = UINavigationController()
    
    override func start() {
        showJobSearch()
    }
    
    private func showJobSearch() {
        let jobSearchCoordinator = JobSearchCoordinator(navigationController: navigationController)
        pushCoordinator(jobSearchCoordinator)
    }
    
    
}
