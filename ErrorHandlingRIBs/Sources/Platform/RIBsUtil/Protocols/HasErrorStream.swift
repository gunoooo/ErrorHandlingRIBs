//
//  HasErrorStream.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/16.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// `ErrorStream`을 제공하는 프로토콜
public protocol HasErrorStream {
    var errorStream: ErrorStream { get }
}

public extension HasErrorStream where Self: HasDependency {
    var errorStream: ErrorStream {
        guard let errorStream = (dependency as? HasErrorStream)?.errorStream else {
            fatalError("\(dependency) should conform to \(HasErrorStream.self)")
        }
        return errorStream
    }
}
