//
//  HasParentErrorStream.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/16.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// 부모 `ErrorStream`을 제공하는 프로토콜
public protocol HasParentErrorStream {
    var parentErrorStream: ErrorStream { get }
}

public extension HasParentErrorStream where Self: HasDependency {
    var parentErrorStream: ErrorStream {
        guard let errorStream = (dependency as? HasErrorStream)?.errorStream else {
            fatalError("\(dependency) should conform to \(HasErrorStream.self)")
        }
        return errorStream
    }
}
