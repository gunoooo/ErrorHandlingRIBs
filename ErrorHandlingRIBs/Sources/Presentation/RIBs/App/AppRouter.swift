//
//  AppRouter.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/19.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs

protocol AppInteractable: Interactable {
    var router: AppRouting? { get set }
}

final class AppRouter: Router<AppInteractable>, AppRouting {

    override init(interactor: AppInteractable) {
        super.init(interactor: interactor)
        interactor.router = self
    }
}
