//
//  InteractableError+MapToCaseableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public extension InteractableError {
    /// 에러 매핑 함수
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
    func mapTo<ErrorCase: ErrorCaseable>(type errorCaseType: ErrorCase.Type) -> CaseableErrorContent<ErrorCase>? {
        guard let error = handleableError.error.mapTo(type: errorCaseType.self) else {
            send()
            return nil
        }
        return error
    }
}
