//
//  HasInteractorDependency.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/17.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation
import RIBs

public protocol HasInteractorDependency {
    var interactorDependency: InteractorDependency { get }
}

extension HasInteractorDependency where Self: HasDependency {
    var interactorDependency: InteractorDependency {
        guard let interactorDependency = dependency as? InteractorDependency else {
            fatalError("\(dependency) should conform to \(InteractorDependency.self)")
        }
        return interactorDependency
    }
}
