//
//  AppCoordinator.swift
//  UalaTest
//
//  Created by Pedro Iván Romero Ojeda on 1/23/21.
//  Copyright © 2021 piro. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    // MARK: - Properties
    let window: UIWindow?
    var rootViewController = UINavigationController()

    // MARK: - Coordinator
    init(window: UIWindow?) {
        self.window = window
    }

    override func start() {
        guard let window = window else { return }
        let homeCoordinator = HomeCoordinator(navigationController: rootViewController)
        addChildCoordinator(homeCoordinator)
        homeCoordinator.start()
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }

    override func finish() {}
}
