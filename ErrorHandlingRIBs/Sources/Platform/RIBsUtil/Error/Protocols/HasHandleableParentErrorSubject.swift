//
//  HasHandleableParentErrorSubject.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/16.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// 부모 `HandleableErrorStream`을 제공하는 프로토콜
public protocol HasHandleableParentErrorSubject {
    var parentHandleableErrorSubject: HandleableErrorSubject { get }
}

public extension HasHandleableParentErrorSubject where Self: HasDependency {
    var parentHandleableErrorSubject: HandleableErrorSubject {
        guard let errorStream = (dependency as? HasHandleableErrorSubject)?.handleableErrorSubject else {
            fatalError("\(dependency) should conform to \(HasHandleableErrorSubject.self)")
        }
        return errorStream
    }
}
