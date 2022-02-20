//
//  Rx+ErrorMapping.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/17.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension InteractorErrorStream {
    /// 에러 매핑 함수
    /// `type` 형태로 에러를 매핑하고, 타입이 맞지 않은 에러는 `ErrorStream`으로 보내줌
    ///
    /// `unhandled` : 현재 RIB에서 발생된 에러가 `Error Scope` 에 포함되지 않는 경우 이벤트
    ///
    /// ```swift
    ///     errorStream
    ///         .mapTo(type: LoginErrorCase.self, unhandled: { unhandledError in
    ///             // show alert
    ///         })
    ///         .map { errorContent, errorCase in
    ///             switch errorCase {
    ///             case .IDError:
    ///                 break
    ///             case .PasswordError:
    ///                 break
    ///             case .ConnectionError:
    ///                 break
    ///         }
    ///     }
    /// ```
    ///
    /// - returns:
    /// `E 타입으로 매핑된 에러`
    func mapTo<ErrorCase: ErrorCaseable>(
        type errorCaseType: ErrorCase.Type,
        unhandled: ((UnhandledError) -> Void)? = nil
    ) -> Observable<ErrorContentWithCase<ErrorCase>> {
        return value
            .do(onNext: { error, errorStream in
                if let unhandledError = error as? UnhandledError {
                    unhandled?(unhandledError)
                }
            })
            .compactMap { element, errorStream -> ErrorContentWithCase? in
                guard let error = element.mapTo(type: errorCaseType.self) else {
                    errorStream.accept(element)
                    return nil
                }
                return error
            }
    }
    
    /// 에러 매핑 함수
    /// `type` 형태로 에러를 매핑하고, 타입이 맞지 않은 에러는 `ErrorStream`으로 보내줌
    ///
    /// ```swift
    ///     errorStream.mapWith(type: LoginErrorCase.self)
    ///         .map { errorContentWithCase, errorStream in
    ///             switch errorContentWithCase.errorCase {
    ///             case .IDError:
    ///                 break
    ///             case .PasswordError:
    ///                 break
    ///             case .ConnectionError:
    ///                 break
    ///         }
    ///     }
    /// ```
    ///
    /// - returns:
    /// `E 타입으로 매핑된 에러`, `ErrorStream`
    func mapWith<ErrorCase: ErrorCaseable>(type errorCaseType: ErrorCase.Type) -> Observable<(ErrorContentWithCase<ErrorCase>, ErrorStream)> {
        return value.compactMap { element, errorStream -> (ErrorContentWithCase, ErrorStream)? in
            guard let error = element.mapTo(type: errorCaseType.self) else {
                errorStream.accept(element)
                return nil
            }
            return (error, errorStream)
        }
    }
}
