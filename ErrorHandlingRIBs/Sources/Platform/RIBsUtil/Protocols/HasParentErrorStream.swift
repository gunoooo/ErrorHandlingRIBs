//
//  HasParentErrorStream.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/16.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// 부모 `HandleableErrorStream`을 제공하는 프로토콜
public protocol HasHandleableParentErrorStream {
    var parentErrorStream: HandleableErrorStream { get }
}

public extension HasHandleableParentErrorStream where Self: HasDependency {
    var parentErrorStream: HandleableErrorStream {
        guard let errorStream = (dependency as? HasHandleableErrorStream)?.errorStream else {
            fatalError("\(dependency) should conform to \(HasHandleableErrorStream.self)")
        }
        return errorStream
    }
}
