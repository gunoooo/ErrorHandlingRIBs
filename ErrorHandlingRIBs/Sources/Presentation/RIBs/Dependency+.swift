//
//  Dependency+.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs

protocol Dependency: RIBs.Dependency,
                     HasHandleableErrorSubject {}

class Component<DependencyType>: RIBs.Component<DependencyType>, Dependency {
    
    var handleableErrorSubject: HandleableErrorSubject {
        guard let handleableErrorSubject = (dependency as? HasHandleableErrorSubject)?.handleableErrorSubject else {
            fatalError("\(dependency) should conform to \(HasHandleableErrorSubject.self)")
        }
        return handleableErrorSubject
    }
}
