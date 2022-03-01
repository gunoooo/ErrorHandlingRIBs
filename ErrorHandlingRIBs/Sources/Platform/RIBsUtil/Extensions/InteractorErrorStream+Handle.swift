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

public extension InteractableErrorStream {
    /// DefaultError 발생시 처리 함수
    /// - handler: 현재 RIB에서 발생된 에러가 `Error Scope` 에 포함되지 않는 경우 이벤트
    func filterDefault(_ handler: @escaping ((DefaultError) -> Void)) -> InteractableErrorStream {
        return compactMap { interactableError in
            if let defaultError = interactableError.handleableError.error as? DefaultError {
                handler(defaultError)
                return nil
            }
            return interactableError
        }
    }
    
    /// DefaultError 발생 함수
    /// - with mapper: Error를 DefaultError로 매핑하는 closure
    func handle(with mapper: @escaping ((Error) -> DefaultError)) -> Disposable {
        return subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { interactableError in
                interactableError.handleableError.handle(with: mapper)
            })
    }
}

public extension HandleableErrorStream {
    /// DefaultError 발생 함수
    /// - with mapper: Error를 DefaultError로 매핑하는 closure
    func handle(with mapper: @escaping ((Error) -> DefaultError)) -> Disposable {
        return subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { handleableError in
                handleableError.handle(with: mapper)
            })
    }
}
