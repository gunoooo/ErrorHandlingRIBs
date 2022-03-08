//
//  AppRouter.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/19.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import UIKit
import RIBs

protocol AppRoutingLogic: AnyObject {
    func activate()
    func attachRoot(window: UIWindow)
}

protocol AppRouting: Routing {}

final class AppRouter: Router<AppInteractable>,
                       AppRouting,
                       AppRoutingLogic {

    private let rootBuilder: RootBuildable
    private var rootRouter: LaunchRouting?
    
    init(
        interactor: AppInteractable,
        rootBuilder: RootBuildable
    ) {
        self.rootBuilder = rootBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    func activate() {
        interactor.activate()
    }
    
    func attachRoot(window: UIWindow) {
        guard rootRouter == nil else {
            return
        }
        
        let router = rootBuilder.build(withListener: interactor)
        router.launch(from: window)
        attachChild(router)
    }
}
