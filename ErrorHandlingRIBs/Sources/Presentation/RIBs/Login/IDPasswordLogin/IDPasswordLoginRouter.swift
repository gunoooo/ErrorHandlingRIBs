//
//  IDPasswordLoginRouter.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/07.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs

protocol IDPasswordLoginInteractable: Interactable {
    var router: IDPasswordLoginRouting? { get set }
    var listener: IDPasswordLoginListener? { get set }
}

protocol IDPasswordLoginViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class IDPasswordLoginRouter: ViewableRouter<IDPasswordLoginInteractable, IDPasswordLoginViewControllable>,
                                   IDPasswordLoginRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: IDPasswordLoginInteractable, viewController: IDPasswordLoginViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
