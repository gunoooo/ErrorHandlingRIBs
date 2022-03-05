//
//  Error.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/03/05.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public extension Error {
    /// Error -> CaseableError
    ///
    /// - returns
    ///     `type` 과 일치한다면, 매핑된 에러. 일치하지 않는다면 nil
    ///
    /// ```swift
    ///     error.mapTo(type: LoginErrorCase.self)
    /// ```
    func mapTo<ErrorCase: ErrorCaseable>(
        type errorCaseType: ErrorCase.Type
    ) -> CaseableError<ErrorCase>? {
        guard let errorContent = self as? ErrorCase.ErrorContent else {
            return nil
        }
        guard let errorCase = errorCaseType.make(from: self) else {
            return nil
        }
        return CaseableError(errorCase: errorCase, errorContent: errorContent)
    }
}
