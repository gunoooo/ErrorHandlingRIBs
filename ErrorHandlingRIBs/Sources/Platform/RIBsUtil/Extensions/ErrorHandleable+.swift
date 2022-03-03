//
//  InteractorErrorStream+Handle.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/22.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension ErrorHandleable where Self: HasDependency & HasInteractableErrorStream {
    /// `ErrorHandleable`의 handle 함수가 실행되었을때,
    /// `ErrorStream`으로 통하게하여 `InteractableErrorStream`의 default 함수로 처리
    func handle(_ error: DefaultError) {
        guard let errorStream = (dependency as? HasHandleableErrorStream)?.errorStream else {
            fatalError("\(dependency) should conform to \(HasHandleableErrorStream.self)")
        }
        errorStream.onNext(HandleableError(error, handler: self))
    }
}
