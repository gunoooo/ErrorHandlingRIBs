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

protocol AppInteractorDependency: HasErrorStream {
    var window: UIWindow? { get set }
}

final class AppInteractor: Interactor,
                           AppInteractable,
                           AppLifecycleDelegate,
                           HasInteractorDependency {

    weak var router: AppRouting?
    
    var dependency: AppInteractorDependency
    
    init(dependency: AppInteractorDependency) {
        self.dependency = dependency
        super.init()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency.errorStream
            .subscribe { [weak self] error in
                self?.dependency.errorStream.startedPoint?.onNext(
                    UnhandledError(
                        message: "오류가 발생하였습니다. 이용에 불편을 드려 죄송합니다.",
                        detailMessage: error.localizedDescription
                    )
                )
            }
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
        let window = dependency.window ?? UIWindow()
        dependency.window = window
        router?.attachRoot(window: window)
        return true
    }
    
    // MARK: RootListener
    
    func exitApp() {
        exit(-1)
    }
}
