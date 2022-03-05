//
//  InteractorErrorHandlable.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public protocol InteractorErrorHandlable: ErrorHandleable, HasErrorHandleableInteractorDependency {
    /// 현재 Interactor에서 핸들링 할 InteractableError Observable
    var errorStream: Observable<InteractableError> { get }
}

public extension InteractorErrorHandlable {
    var errorStream: Observable<InteractableError> {
        return errorHandlingInteractorDependency.handleableErrorSubject
            .map {
                $0.mapToInteractableError(handleableErrorSubject: errorHandlingInteractorDependency.parentHandleableErrorSubject)
            }
    }
}

public extension ErrorHandleable where Self: InteractorErrorHandlable {
    /// `ErrorHandleable`의 handle 함수가 실행되었을때,
    /// `ErrorStream`으로 통하게하여 `InteractableErrorStream`의 default 함수로 처리
    func handle(_ error: Error) {
        errorHandlingInteractorDependency
            .handleableErrorSubject
            .onNext(HandleableError(error, handler: self))
    }
}

public extension ObservableType {
    /// 에러 발생시 `to` 의 `HandleableErrorSubject`로 Error를 이동시키는 함수
    ///
    /// - Parameters:
    ///  - handler: `ErrorHandleable`을 채택하여 에러 처리 로직이 구현된 객체 & 에러 발생시 onNext 시킬 `HandleableErrorSubject`을 소유한 객체
    ///
    /// - returns:
    /// 에러가 필터링된 Observable
    func catchAndThrow(
        to handler: InteractorErrorHandlable
    ) -> Observable<Element> {
        return `catch` { error in
            handler
                .errorHandlingInteractorDependency
                .handleableErrorSubject
                .onNext(HandleableError(error, handler: handler))
            return .empty()
        }
    }
}
