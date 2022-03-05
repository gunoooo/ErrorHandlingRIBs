//
//  CaseableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

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
