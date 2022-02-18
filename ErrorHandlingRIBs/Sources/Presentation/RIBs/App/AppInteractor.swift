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

protocol AppRouting: Routing {}

protocol AppInteractorDependency: ErrorHandlingInteractorDependency {}

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
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    // MARK: - AppLifecycleDelegate
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?
    ) -> Bool {
        return false
    }
}
