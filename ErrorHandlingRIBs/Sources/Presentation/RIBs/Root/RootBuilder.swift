//
//  RootBuilder.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/19.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {}

final class RootComponent: Component<RootDependency>,
                           RootInteractorDependency {
    
    var errorStream: ErrorStream {
        shared {
            .init()
        }
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build(withListener listener: RootListener) -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RootListener) -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(dependency: component, presenter: viewController)
        interactor.listener = listener
        return RootRouter(interactor: interactor, viewController: viewController)
    }
}
