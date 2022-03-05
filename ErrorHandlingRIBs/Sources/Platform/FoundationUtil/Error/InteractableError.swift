//
//  InteractableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

/// 상호작용이 가능한 에러
///
/// 다른 `errorSubject`으로 현재 에러를  보낼수 있는 에러
public struct InteractableError: Error {
    
    public var handleableError: HandleableError
    
    private var handleableErrorSubject: HandleableErrorSubject
    
    public init(
        _ handleableError: HandleableError,
        handleableErrorSubject: HandleableErrorSubject
    ) {
        self.handleableError = handleableError
        self.handleableErrorSubject = handleableErrorSubject
    }
    
    public func send() {
        handleableErrorSubject.onNext(handleableError)
    }
}

public extension InteractableError {
    /// InteractableError -> CaseableError
    /// `type` 형태로 에러를 매핑하고, 타입이 맞지 않은 에러는 `ErrorStream`으로 보내줌
    ///
    /// ```swift
    ///     let caseableErrorContent = error.mapTo(type: LoginErrorCase.self)
    ///
    ///     switch caseableErrorContent.errorCase {
    ///     case .IDError:
    ///         break
    ///     case .PasswordError:
    ///         break
    ///     case .ConnectionError:
    ///         break
    ///     }
    /// ```
    ///
    /// - returns:
    /// `E 타입으로 매핑된 에러`
    func mapTo<ErrorCase: ErrorCaseable>(type errorCaseType: ErrorCase.Type) -> CaseableError<ErrorCase>? {
        guard let error = handleableError.error.mapTo(type: errorCaseType.self) else {
            return nil
        }
        return error
    }
}

public extension Observable where Element == InteractableError {
    /// 에러 전송 함수
    func send() -> Disposable {
        return observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { interactableError in
                interactableError.send()
            })
    }
    
    /// 에러 필터링 함수
    /// `ErrorCaseable` 형태로 에러를 필터링후 처리
    ///
    /// ```swift
    ///     errorStream
    ///         .filter(type: RootErrorCase.Messaging.self) { [weak self] error in
    ///             switch error.errorCase {
    ///             case .SecureError:
    ///                 // TODO: 알럿처리
    ///                 self?.listener?.exitApp()
    ///             }
    ///          }
    ///         .filter(type: RootErrorCase.DetailMessaging.self) { error in
    ///             switch error.errorCase {
    ///             case .ConnectionError:
    ///                 break
    ///             }
    ///         }
    /// ```
    ///
    /// - returns:
    /// `ErrorCaseable 타입이 필터링된 에러`
    func filter<ErrorCase: ErrorCaseable>(
        type errorCaseType: ErrorCase.Type,
        _ handler: @escaping ((CaseableError<ErrorCase>) -> Void)
    ) -> Observable<InteractableError> {
        return compactMap { interactableError in
            guard let caseableErrorContent = interactableError.mapTo(type: errorCaseType) else {
                return interactableError
            }
            handler(caseableErrorContent)
            return nil
        }
    }
}
