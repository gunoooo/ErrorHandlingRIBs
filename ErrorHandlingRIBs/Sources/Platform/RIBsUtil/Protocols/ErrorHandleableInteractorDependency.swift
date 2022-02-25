//
//  ErrorHandleableInteractorDependency.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/17.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// 에러처리가 가능한 `Interactor`의 의존성 주입을 위한 Dependency
public typealias ErrorHandleableInteractorDependency = InteractorDependency &
                                                       HasHandleableErrorStream &
                                                       HasHandleableParentErrorStream
