//
//  IDPasswordLoginRouter.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/07.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs

protocol IDPasswordLoginRouting: ViewableRouting {}

protocol IDPasswordLoginRoutingLogic: AnyObject {}

final class IDPasswordLoginRouter: ViewableRouter<IDPasswordLoginInteractable, IDPasswordLoginViewControllable>,
                                   IDPasswordLoginRouting,
                                   IDPasswordLoginRoutingLogic {}
