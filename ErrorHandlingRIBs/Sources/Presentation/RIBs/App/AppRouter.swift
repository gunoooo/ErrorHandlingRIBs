//
//  AppRouter.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/19.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import UIKit
import RIBs

protocol AppInteractable: Interactable,
                          RootListener {
    var router: AppRouting? { get set }
}

final class AppRouter: Router<AppInteractable>, AppRouting {

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
    
    func attachRoot(window: UIWindow) {
        guard rootRouter == nil else {
            return
        }
        
        let router = rootBuilder.build(withListener: interactor)
        router.launch(from: window)
        attachChild(router)
    }
}
