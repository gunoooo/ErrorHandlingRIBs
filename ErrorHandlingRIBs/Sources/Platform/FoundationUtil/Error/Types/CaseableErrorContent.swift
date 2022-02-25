//
//  CaseableErrorContent.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

public protocol CaseableErrorContentType {}

public struct CaseableErrorContent<ErrorCase: ErrorCaseable>: CaseableErrorContentType {
    
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
