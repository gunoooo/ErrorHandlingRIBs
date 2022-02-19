//
//  AppBuilder.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import UIKit
import RIBs

final class AppComponent: Component<EmptyDependency>,
                          AppInteractorDependency {
    
    var errorStream: ErrorStream {
        shared {
            .init()
        }
    }
    
    var window: UIWindow?
    
    init(
        dependency: EmptyDependency,
        window: UIWindow?
    ) {
        self.window = window
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol AppBuildable: Buildable {
    func build(withWindow window: UIWindow?) -> (routing: AppRouting, lifecycleDelegate: AppLifecycleDelegate)
}

final class AppBuilder: Builder<EmptyDependency>, AppBuildable {

    override init(dependency: EmptyDependency) {
        super.init(dependency: dependency)
    }

    func build(withWindow window: UIWindow?) -> (routing: AppRouting, lifecycleDelegate: AppLifecycleDelegate) {
        let component = AppComponent(dependency: dependency, window: window)
        let interactor = AppInteractor(dependency: component)
        
        let rootBuilder = RootBuilder(dependency: component)
        
        let router = AppRouter(interactor: interactor, rootBuilder: rootBuilder)
        
        return (router, interactor)
    }
}
