//
//  AppCoordinator.swift
//  Worksmile-app
//
//  Created by Karol Majka on 22/11/2020.
//

import UIKit

final class AppCoordinator: Coordinator {
    var presentation: CoordinatorPresentation {
        return dependencies.presentation
    }
    var rootController: UIViewController?

    struct Dependencies {
        let presentation: CoordinatorPresentation
    }
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func start() {
        let viewModel = PathViewModel(
            dependencies: .init(pointsService: AppDependencies.current.pointsService,
                                anomalyInteractor: PathAnomalyInteractor()
            ))
        let controller = PathViewController()
        controller.viewModel = viewModel

        let navigationController = NavigationController(rootViewController: controller)
        present(viewController: navigationController)
    }
}
