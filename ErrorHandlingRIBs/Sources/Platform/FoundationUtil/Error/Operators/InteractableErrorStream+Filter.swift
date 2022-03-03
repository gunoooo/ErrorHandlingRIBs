//
//  InteractableErrorStream+MapToCaseableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension InteractableErrorStream {
    /// 에러 필터링 함수
    /// `ErrorCaseable` 형태로 에러를 필터링후 처리하고, 타입이 맞지 않은 에러는 `ErrorStream`으로 보내줌
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
    ) -> InteractableErrorStream {
        return compactMap { interactableError in
            guard let caseableErrorContent = interactableError.mapTo(type: errorCaseType) else {
                return interactableError
            }
            handler(caseableErrorContent)
            return nil
        }
    }
    
    /// DefaultError 필터링 함수
    ///
    /// - returns:
    /// `DefaultError 타입이 필터링된 에러`
    func filterDefault(_ handler: @escaping ((DefaultError) -> Void)) -> InteractableErrorStream {
        return compactMap { interactableError in
            if let defaultError = interactableError.handleableError.error as? DefaultError {
                handler(defaultError)
                return nil
            }
            return interactableError
        }
    }
}
