//
//  HandleableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// 처리가 가능한 형태의 에러
///
/// 에러 처리를 담당하는 `handler`를 통하여 처리를 실행할수 있는 형태의 에러
public struct HandleableError {
    
    public var error: Error
    
    private var handler: ErrorHandleable
    
    public init(
        _ error: Error,
        handler: ErrorHandleable
    ) {
        self.error = error
        self.handler = handler
    }
    
    public func handle(with mapper: @escaping ((Error) -> DefaultError)) {
        handler.handle(mapper(error))
    }
}
