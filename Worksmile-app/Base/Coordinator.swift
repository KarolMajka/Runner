//
//  Coordinator.swift
//  Worksmile-app
//
//  Created by Karol Majka on 22/11/2020.
//

import UIKit

enum CoordinatorPresentation {
    case push(navigationController: UINavigationController)
    case present(presentingController: UIViewController)
    case window(window: UIWindow)
}

protocol Coordinator: class {
    var presentation: CoordinatorPresentation { get }
    var rootController: UIViewController? { get set }

    func start()
}

extension Coordinator {
    var rootNavigationController: UINavigationController? {
        return rootController as? UINavigationController ?? rootController?.navigationController
    }
}

// MARK: - Presentation
extension Coordinator {
    func present(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        rootController = viewController

        switch presentation {
        case .present(let presentingController):
            presentingController.present(viewController, animated: animated, completion: completion)
        case .push(let navigationController):
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            navigationController.pushViewController(viewController, animated: animated)
            CATransaction.commit()
        case let .window(window):
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            completion?()
        }
    }

    func finish(animated: Bool = true, completion: (() -> Void)? = nil) {
        switch presentation {
        case .present:
            rootController?.dismiss(animated: animated, completion: completion)
        case .push(let navigationController):
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            if let indexOfRootController = navigationController.viewControllers.firstIndex(where: { $0 === rootController }),
                let toViewController = navigationController.viewControllers[safe: indexOfRootController - 1] {
                navigationController.popToViewController(toViewController, animated: animated)
            } else {
                navigationController.popViewController(animated: animated)
            }
            CATransaction.commit()
        case .window(let window):
            window.removeFromSuperview()
            completion?()
        }
    }
}
