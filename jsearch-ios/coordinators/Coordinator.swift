//
//  Coordinator.swift
//  jsearch-ios
//
//  Created by Ruchira on 2021-09-12.
//

import UIKit
import RxSwift

class Coordinator: NSObject {
    
    var didFinish: ((Coordinator) -> Void)?
    
    var childCoordinators: [Coordinator] = []
    
    let bag = DisposeBag()
    
    func start() {}
    
    func finish(_ animated: Bool) {}
    
    func pushCoordinator(_ coordinator: Coordinator) {
        // Install Handler
        coordinator.didFinish = { [weak self] (coordinator) in
            self?.popCoordinator(coordinator)
        }
        
        // Start Coordinator
        coordinator.start()
        
        // Append to Child Coordinators
        childCoordinators.append(coordinator)
    }
    
    private func popCoordinator(_ coordinator: Coordinator) {
        // Remove Coordinator From Child Coordinators
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
