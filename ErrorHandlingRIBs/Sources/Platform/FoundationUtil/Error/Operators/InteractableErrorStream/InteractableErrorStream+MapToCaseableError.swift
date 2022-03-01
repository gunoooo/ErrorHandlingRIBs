//
//  InteractableErrorStream+MapToCaseableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import RxSwift

public extension InteractableErrorStream {
    /// 에러 매핑 함수
    /// `type` 형태로 에러를 매핑하고, 타입이 맞지 않은 에러는 `ErrorStream`으로 보내줌
    ///
    /// ```swift
    ///     errorStream
    ///         .mapTo(type: LoginErrorCase.self)
    ///         .handle { errorCase, errorContent in
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
    func filter<ErrorCase: ErrorCaseable>(
        type errorCaseType: ErrorCase.Type,
        _ handler: @escaping ((CaseableErrorContent<ErrorCase>) -> Void)
    ) -> InteractableErrorStream {
        return compactMap { interactableError in
            guard let caseableErrorContent = interactableError.mapTo(type: errorCaseType) else {
                return interactableError
            }
            handler(caseableErrorContent)
            return nil
        }
    }
    
    /// 에러 전송 함수
    func send(before handler: ((DefaultError) -> Void)? = nil) -> Disposable {
        return subscribe(onNext: { interactableError in
            if let defaultError = interactableError.handleableError.error as? DefaultError {
                handler?(defaultError)
                return
            }
            interactableError.send()
        })
    }
}
