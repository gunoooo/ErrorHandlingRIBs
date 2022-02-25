//
//  AppBuilder.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import UIKit
import RIBs

final class AppComponent: EmptyComponent,
                          AppInteractorDependency {
    
    var errorStream: HandleableErrorStream
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        errorStream = .init()
        self.window = window
    }
}

// MARK: - Builder

protocol AppBuildable: Buildable {
    func build(withWindow window: UIWindow?) -> (routing: AppRouting, lifecycleDelegate: AppLifecycleDelegate)
}

final class AppBuilder: Builder<EmptyDependency>, AppBuildable {

    init() {
        super.init(dependency: EmptyComponent())
    }

    func build(withWindow window: UIWindow?) -> (routing: AppRouting, lifecycleDelegate: AppLifecycleDelegate) {
        let component = AppComponent(window: window)
        let interactor = AppInteractor(dependency: component)
        
        let rootBuilder = RootBuilder(dependency: component)
        
        let router = AppRouter(interactor: interactor, rootBuilder: rootBuilder)
        
        return (router, interactor)
    }
}
