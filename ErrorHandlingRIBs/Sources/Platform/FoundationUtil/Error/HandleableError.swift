//
//  HandleableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

/// `handler`를 통하여  처리가 가능한 형태의 에러
///
/// 에러 처리를 담당하는 `handler`를 통하여 처리를 실행할수 있는 형태의 에러
public struct HandleableError: Error {
    
    public var error: Error
    
    private var handler: ErrorHandleable
    
    public init(
        _ error: Error,
        handler: ErrorHandleable
    ) {
        self.error = error
        self.handler = handler
    }
    
    /// Error 발생 함수
    ///
    /// - Parameters:
    ///     - mapper: Error를 매핑하는 closure
    public func execute(with mapper: ((Error) -> Error)? = nil) {
        if let mapper = mapper {
            handler.handle(mapper(error))
            return
        }
        handler.handle(error)
    }
}

public extension HandleableError {
    /// HandleableError -> InteractableError
    func mapToInteractableError(handleableErrorSubject: HandleableErrorSubject) -> InteractableError {
        return InteractableError(self, handleableErrorSubject: handleableErrorSubject)
    }
}

public typealias HandleableErrorSubject = PublishSubject<HandleableError>

/// `HandleableErrorSubject`을 제공하는 프로토콜
public protocol HasHandleableErrorSubject {
    var handleableErrorSubject: HandleableErrorSubject { get }
}
