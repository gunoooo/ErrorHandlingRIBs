//
//  CaseableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

/// Enum case 형태로 처리가 가능한 에러
public struct CaseableError<ErrorCase: ErrorCaseable>: Error {
    
    public var errorCase: ErrorCase
    
    public var errorContent: ErrorCase.ErrorContent
    
    public init(
        errorCase: ErrorCase,
        errorContent: ErrorCase.ErrorContent
    ) {
        self.errorCase = errorCase
        self.errorContent = errorContent
    }
}

public extension ObservableType {
    /// 에러 필터링 함수
    /// `ErrorCaseable` 형태로 에러를 필터링후 처리
    ///
    /// ```swift
    ///     idPasswordLoginUseCase.login()
    ///         .filter(type: IDPasswordLoginUseCaseError.self) { [weak self] error in
    ///             switch error.errorCase {
    ///             case .SecureError:
    ///                 // 알럿처리
    ///                 self?.listener?.exitApp()
    ///             }
    ///          }
    /// ```
    ///
    /// - returns:
    /// `ErrorCaseable 타입이 필터링된 에러`
    func filter<ErrorCase: ErrorCaseable>(
        type errorCaseType: ErrorCase.Type,
        _ handler: @escaping ((CaseableError<ErrorCase>) -> Void)
    ) -> Observable<Element> {
        return `catch` { error in
            guard let caseableError = error.mapTo(type: errorCaseType) else {
                throw error
            }
            handler(caseableError)
            return .empty()
        }
    }
}

public extension ObservableType where Element == InteractableError {
    /// 에러 필터링 함수
    /// `ErrorCaseable` 형태로 에러를 필터링후 처리
    ///
    /// ```swift
    ///     errorStream
    ///         .filter(type: RootErrorCase.Messaging.self) { [weak self] error in
    ///             switch error.errorCase {
    ///             case .SecureError:
    ///                 // 알럿처리
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
