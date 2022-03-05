//
//  HasErrorHandleableInteractorDependency.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/05.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public protocol HasErrorHandleableInteractorDependency {
    var errorHandlingInteractorDependency: ErrorHandleableInteractorDependency { get }
}

public extension HasErrorHandleableInteractorDependency where Self: HasInteractorDependency {
    var errorHandlingInteractorDependency: ErrorHandleableInteractorDependency {
        guard let errorHandlingInteractorDependency = interactorDependency as? ErrorHandleableInteractorDependency else {
            fatalError("\(interactorDependency) should conform to \(ErrorHandleableInteractorDependency.self)")
        }
        return errorHandlingInteractorDependency
    }
}
