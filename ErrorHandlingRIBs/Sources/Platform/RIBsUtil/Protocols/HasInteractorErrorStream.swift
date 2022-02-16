//
//  HasInteractorErrorStream.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/17.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public protocol HasInteractorErrorStream {
    var errorStream: InteractorErrorStream { get }
}

public extension HasInteractorErrorStream where Self: HasInteractorDependency {
    var errorStream: InteractorErrorStream {
        guard let errorHandlingInteractorDependency = interactorDependency as? ErrorHandlingInteractorDependency else {
            fatalError("\(interactorDependency) should conform to \(ErrorHandlingInteractorDependency.self)")
        }
        return errorHandlingInteractorDependency.errorStream
            .combine(errorStream: errorHandlingInteractorDependency.parentErrorStream)
    }
}

fileprivate extension ObservableType where Element: Error {
    /// `ErrorStream`을 현재의 스트림에 붙이고 `InteractorErrorStream` 형태로 Return 한다
    func combine(errorStream: ErrorStream) -> InteractorErrorStream {
        return map { element -> InteractorError in
            return (element, errorStream)
        }
    }
}
