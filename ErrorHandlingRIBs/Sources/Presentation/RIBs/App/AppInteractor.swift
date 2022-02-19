//
//  AppInteractor.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import UIKit
import RIBs
import RxSwift

protocol AppRouting: Routing {
    func attachRoot(window: UIWindow)
}

protocol AppInteractorDependency: ErrorHandlingInteractorDependency {
    var window: UIWindow? { get set }
}

final class AppInteractor: Interactor,
                           AppInteractable,
                           AppLifecycleDelegate,
                           HasInteractorDependency,
                           HasInteractorErrorStream {

    weak var router: AppRouting?
    
    var dependency: AppInteractorDependency
    
    init(dependency: AppInteractorDependency) {
        self.dependency = dependency
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        errorStream
            .subscribe(onNext: { _ in
                // TODO: 핸들링되지 않은 에러 처리
            })
            .disposeOnDeactivate(interactor: self)
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    // MARK: - AppLifecycleDelegate
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
    ) -> Bool {
        let window = UIWindow()
        dependency.window = window
        router?.attachRoot(window: window)
        return true
    }
    
    // MARK: RootListener
    
    func exitApp() {
        exit(-1)
    }
}
