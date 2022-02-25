//
//  Dependency+.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/18.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RIBs

protocol Dependency: RIBs.Dependency,
                     HasHandleableErrorStream {}

class Component<DependencyType>: RIBs.Component<DependencyType>, Dependency {
    
    var errorStream: HandleableErrorStream {
        guard let errorStream = (dependency as? HasHandleableErrorStream)?.errorStream else {
            fatalError("\(dependency) should conform to \(HasHandleableErrorStream.self)")
        }
        return errorStream
    }
}
