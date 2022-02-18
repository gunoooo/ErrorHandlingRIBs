//
//  AppBuilder.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs

final class AppComponent: Component<EmptyDependency>,
                          AppInteractorDependency {
    
    var errorStream: ErrorStream {
        shared {
            .init()
        }
    }
}

// MARK: - Builder

protocol AppBuildable: Buildable {
    func build() -> (routing: AppRouting, lifecycleDelegate: AppLifecycleDelegate)
}

final class AppBuilder: Builder<EmptyDependency>, AppBuildable {

    override init(dependency: EmptyDependency) {
        super.init(dependency: dependency)
    }

    func build() -> (routing: AppRouting, lifecycleDelegate: AppLifecycleDelegate) {
        let component = AppComponent(dependency: dependency)
        let interactor = AppInteractor(dependency: component)
        let router = AppRouter(interactor: interactor)
        return (router, interactor)
    }
}
