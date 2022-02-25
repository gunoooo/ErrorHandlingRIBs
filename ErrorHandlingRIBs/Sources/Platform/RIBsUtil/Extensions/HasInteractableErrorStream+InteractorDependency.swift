//
//  HasInteractableErrorStream+Dependency.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public extension HasInteractableErrorStream where Self: HasInteractorDependency {
    var errorStream: InteractableErrorStream {
        guard let errorHandlingInteractorDependency = interactorDependency as? ErrorHandleableInteractorDependency else {
            fatalError("\(interactorDependency) should conform to \(ErrorHandleableInteractorDependency.self)")
        }
        return errorHandlingInteractorDependency.errorStream
            .mapToInteractableError(errorStream: errorHandlingInteractorDependency.parentErrorStream)
    }
}
