//
//  Error+.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/13.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public extension Error {
    /// error를 contentType, caseType 으로 매핑
    ///
    /// - returns
    ///     error가 contentType 과 caseType 에 일치한다면, 매핑된 에러. 일치하지 않는다면 nil
    ///
    /// ```swift
    ///     error.mapTo(type: LoginErrorCase.self)
    ///         .map { (errorContent: HasMessage, errorCase: LoginErrorCase) in
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
    func mapTo<ErrorCase: ErrorCaseable>(
        type errorCaseType: ErrorCase.Type
    ) -> (errorContent: ErrorCase.ErrorContent, errorCase: ErrorCase)? {
        guard let errorContent = self as? ErrorCase.ErrorContent else {
            return nil
        }
        guard let errorCase = errorCaseType.make(from: self) else {
            return nil
        }
        return (errorContent, errorCase)
    }
}
