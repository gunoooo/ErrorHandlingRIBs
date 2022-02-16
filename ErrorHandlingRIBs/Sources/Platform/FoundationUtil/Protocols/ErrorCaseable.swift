//
//  ErrorCaseable.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/13.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// `Case` 화 된 에러의 프로토콜
///
/// ```swift
///     enum LoginErrorCase: ErrorCaseable {
///         typealias ErrorContent = HasMessage
///
///         case IDError
///         case PasswordError
///         case ConnectionError
///     }
/// ```
public protocol ErrorCaseable: CaseIterable {
    /// 에러 내용 타입
    associatedtype ErrorContent
    /// from `error`의 이름과 모든 case 이름을 비교하여 동일한 case가 있다면,
    /// 해당 case를 리턴. 없다면 nil을 리턴.
    static func make(from error: Error) -> Self?
}

public extension ErrorCaseable {
    static func make(from error: Error) -> Self? {
        self.allCases
            .filter {
                return "\($0)" == "\(type(of: error).self)"
            }
            .first
    }
}
