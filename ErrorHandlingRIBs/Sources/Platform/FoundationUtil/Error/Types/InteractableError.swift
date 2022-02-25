//
//  InteractableError.swift
//  ErrorHandlingRIBs
//
//  Created by Gunoo on 2022/02/24.
//  Copyright © 2022 com.gunoooo. All rights reserved.
//

import Foundation

/// 상호작용이 가능한 에러
///
/// 다른 `errorStream`으로 현재 에러를  보낼수 있는 형태의 에러
public struct InteractableError {
    
    public var handleableError: HandleableError
    
    private var errorStream: HandleableErrorStream
    
    public init(
        _ handleableError: HandleableError,
        errorStream: HandleableErrorStream
    ) {
        self.handleableError = handleableError
        self.errorStream = errorStream
    }
    
    public func send() {
        errorStream.onNext(handleableError)
    }
}
